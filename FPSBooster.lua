task.spawn(function()
    repeat task.wait() until game:IsLoaded()
    repeat task.wait() until game:GetService("Players").LocalPlayer
    print("[✅ AutoRun Detected Player Loaded]")
end)
setfpscap(22)
getgenv().BlackModeConfig = {
    enableBlackOverlay = true,
    overlayZIndex = 100000,
    overlayTransparency = 0,
    reduceGraphics = true,
    minimalQualityLevel = 1,
    toggleKey = Enum.KeyCode.F5
}

task.spawn(function()
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    local gui = Instance.new("ScreenGui")
    gui.Name = "TopTextGUI"
    gui.DisplayOrder = 999999
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = game:GetService("CoreGui")

    -- Username Label
    local usernameLabel = Instance.new("TextLabel")
    usernameLabel.Size = UDim2.new(0, 300, 0, 35)
    usernameLabel.Position = UDim2.new(0.5, -150, 0, 10)
    usernameLabel.BackgroundTransparency = 1
    usernameLabel.TextColor3 = Color3.new(1, 1, 1)
    usernameLabel.Font = Enum.Font.SourceSansBold
    usernameLabel.TextSize = 26
    usernameLabel.Text = LocalPlayer.Name
    usernameLabel.TextStrokeTransparency = 0.5
    usernameLabel.ZIndex = 999999
    usernameLabel.Parent = gui

    -- FPS Label
    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Size = UDim2.new(0, 300, 0, 35)
    fpsLabel.Position = UDim2.new(0.5, -150, 1, -50)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.TextColor3 = Color3.new(1, 1, 1)
    fpsLabel.Font = Enum.Font.SourceSansBold
    fpsLabel.TextSize = 26
    fpsLabel.Text = "FPS: 0"
    fpsLabel.TextStrokeTransparency = 0.5
    fpsLabel.ZIndex = 999999
    fpsLabel.Parent = gui

    -- Label Tengah: Cica
    local ownerLabel = Instance.new("TextLabel")
    ownerLabel.Size = UDim2.new(0, 400, 0, 60)
    ownerLabel.Position = UDim2.new(0.5, -200, 0.5, -30)
    ownerLabel.BackgroundTransparency = 1
    ownerLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    ownerLabel.Font = Enum.Font.SourceSansBold
    ownerLabel.TextSize = 26
    ownerLabel.Text = "⚡ Cica FPS BOOSTER ⚡"
    ownerLabel.TextStrokeTransparency = 0.5
    ownerLabel.ZIndex = 999999
    ownerLabel.Parent = gui

    local frameCount, lastUpdate = 0, tick()
    RunService.RenderStepped:Connect(function()
        frameCount += 1
        local now = tick()
        if now - lastUpdate >= 1 then
            local fps = math.floor(frameCount / (now - lastUpdate))
            fpsLabel.Text = "FPS: " .. fps
            frameCount = 0
            lastUpdate = now
        end
    end)
end)

task.spawn(function()
    local cfg = getgenv().BlackModeConfig
    local UserInput = game:GetService("UserInputService")
    local overlayGui

    local function createOverlay()
        overlayGui = Instance.new("ScreenGui")
        overlayGui.Name = "BlackScreenOverlay"
        overlayGui.IgnoreGuiInset = true
        overlayGui.DisplayOrder = cfg.overlayZIndex
        overlayGui.ResetOnSpawn = false
        overlayGui.Parent = game:GetService("CoreGui")

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.new(0, 0, 0)
        frame.BackgroundTransparency = cfg.overlayTransparency
        frame.BorderSizePixel = 0
        frame.ZIndex = cfg.overlayZIndex
        frame.Parent = overlayGui

        local statusLabel = Instance.new("TextLabel")
        statusLabel.Size = UDim2.new(0, 300, 0, 35)
        statusLabel.Position = UDim2.new(0, 10, 0, 10)
        statusLabel.BackgroundTransparency = 1
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        statusLabel.Font = Enum.Font.Code
        statusLabel.TextSize = 26
        statusLabel.Text = "[BLACK MODE: ON]"
        statusLabel.ZIndex = cfg.overlayZIndex + 1
        statusLabel.Parent = overlayGui
    end

    local function removeOverlay()
        if overlayGui then overlayGui:Destroy() overlayGui = nil end
    end

    if cfg.enableBlackOverlay then createOverlay() end

    UserInput.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == cfg.toggleKey then
            if overlayGui then
                removeOverlay()
                print("[BLACK MODE OFF]")
            else
                createOverlay()
                print("[BLACK MODE ON]")
            end
        end
    end)
end)
