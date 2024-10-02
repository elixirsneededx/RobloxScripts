local teleportToggle = false
local teleportCooldown = 660
local remainingTime = teleportCooldown
local targetX = 28.07463836669922
local targetY = 83.6776922802734
local targetZ = -1077.6444091796875

local player = game.Players.LocalPlayer
local teleportLoop
local firstTeleport = true

local screenGui = Instance.new("ScreenGui")
local backgroundFrame = Instance.new("Frame")
local toggleButton = Instance.new("TextButton")
local descriptionLabel = Instance.new("TextLabel")
local titleLabel = Instance.new("TextLabel")

screenGui.Parent = game.CoreGui

backgroundFrame.Parent = screenGui
backgroundFrame.Size = UDim2.new(0, 350, 0, 200)
backgroundFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
backgroundFrame.BackgroundColor3 = Color3.fromRGB(169, 169, 169)
backgroundFrame.Active = true
backgroundFrame.Draggable = true

toggleButton.Parent = backgroundFrame
toggleButton.Size = UDim2.new(0, 200, 0, 50)
toggleButton.Position = UDim2.new(0.5, -100, 0.5, -25)
toggleButton.Text = "Start Script"
toggleButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)

descriptionLabel.Parent = backgroundFrame
descriptionLabel.Size = UDim2.new(0, 300, 0, 50)
descriptionLabel.Position = UDim2.new(0.5, -150, 0.5, 50)
descriptionLabel.Text = "This will teleport you to the bottom of the hole every 11 minutes, just leave it AFK and get 100k wins per 11 minutes."
descriptionLabel.TextScaled = true
descriptionLabel.BackgroundTransparency = 1
descriptionLabel.TextColor3 = Color3.fromRGB(128, 0, 128)

titleLabel.Parent = backgroundFrame
titleLabel.Size = UDim2.new(0, 100, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "MommyMilkers"
titleLabel.TextScaled = true
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

local function teleportToCoordinates()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = player.Character.HumanoidRootPart
        humanoidRootPart.CFrame = CFrame.new(targetX, targetY, targetZ)
        print("Teleported to coordinates.")
    end
end

local function runTeleportTimer()
    while teleportToggle and remainingTime > 0 do
        print("Time left until next teleport: " .. remainingTime .. " seconds")
        wait(1)
        remainingTime = remainingTime - 1
        
        if remainingTime <= 0 then
            teleportToCoordinates()
            remainingTime = teleportCooldown
        end
    end
end

local function toggleTeleport()
    teleportToggle = not teleportToggle
    if teleportToggle then
        toggleButton.Text = "Stop Script"
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        print("Teleport loop started.")
        if firstTeleport then
            teleportToCoordinates()
            firstTeleport = false
            remainingTime = teleportCooldown
        end
        teleportLoop = coroutine.create(runTeleportTimer)
        coroutine.resume(teleportLoop)
    else
        toggleButton.Text = "Start Script"
        toggleButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
        print("Teleport loop stopped. Time left: " .. remainingTime .. " seconds.")
    end
end

toggleButton.MouseButton1Click:Connect(toggleTeleport)
