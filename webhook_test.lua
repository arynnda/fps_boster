-- webhook_brainrot_ready.lua
-- ==============================================================
-- 🧠 Webhook Notifier - Rare Pet Detector (Secret / Admin / Lucky)
-- ==============================================================

-- ⚠️ DISCLAIMER:
-- This file contains your Discord webhook URL and Discord user ID.
-- Keep it private. Do not share publicly.

task.spawn(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local HttpService = game:GetService("HttpService")

    -- Config checks
    if not getgenv().Config or not getgenv().Config["Webhook"] then
        getgenv().Config = getgenv().Config or {}
        getgenv().Config["Webhook"] = getgenv().Config["Webhook"] or {}
    end

    -- === USER SETTINGS (already filled) ===
    getgenv().Config["Webhook"]["Enabled"] = true
    getgenv().Config["Webhook"]["WebhookUrl"] = "https://discord.com/api/webhooks/1410612801675726879/Kfz6QnPrnPUVToPh35NoakP9aeTEhw9rzd0OY0gsCzth1KE7jaPA_Kh_8qajVRJpXz2g"
    local DISCORD_USER_ID = "370453221572870145"

    local WEBHOOK_URL = getgenv().Config["Webhook"]["WebhookUrl"]
    if not getgenv().Config["Webhook"]["Enabled"] or WEBHOOK_URL == "" then return end

    local RARE_KEYWORDS = {
        "brainrot secret admin",
        "secret",
        "admin lucky block",
        "los lucky blocks",
        "secret lucky block",
    }

    local function sendWebhook(petName)
        local mention = "<@" .. DISCORD_USER_ID .. ">"
        local data = {
            ["content"] = mention,
            ["embeds"] = {{
                ["title"] = "🎉 Rare Pet Ditemukan!",
                ["description"] = string.format("**%s** baru saja mendapatkan pet **%s** 💎🔥", LocalPlayer.Name, petName),
                ["color"] = 16755200,
                ["fields"] = {
                    {["name"] = "🧠 Player", ["value"] = LocalPlayer.Name, ["inline"] = true},
                    {["name"] = "🎮 Game", ["value"] = tostring(game.PlaceId), ["inline"] = true},
                },
                ["footer"] = {["text"] = "Arynnda"},
                ["timestamp"] = DateTime.now():ToIsoDate(),
            }}
        }

        local jsonData = HttpService:JSONEncode(data)
        local request = request or http_request or syn.request or http.request
        if request then
            request({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonData
            })
        else
            warn("❌ Webhook tidak bisa dikirim (executor tidak mendukung HTTP request)")
        end
    end

    local function isRarePet(name)
        for _, keyword in pairs(RARE_KEYWORDS) do
            if name:lower():find(keyword) then
                return true
            end
        end
        return false
    end

    local function checkInventory()
        for _, pet in pairs(LocalPlayer:WaitForChild("Backpack"):GetChildren()) do
            if isRarePet(pet.Name) then
                sendWebhook(pet.Name)
                break
            end
        end
    end

    while task.wait(5) do
        pcall(checkInventory)
    end
end)
