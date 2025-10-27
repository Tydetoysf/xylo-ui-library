local NeptuneUI = {}

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

function NeptuneUI.CreateWindow(title)
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "NeptuneUI"
    gui.ResetOnSpawn = false

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, 600, 0, 400)
    main.Position = UDim2.new(0.5, -300, 0.5, -200)
    main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    main.BorderSizePixel = 0
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

    local titleBar = Instance.new("TextLabel", main)
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundTransparency = 1
    titleBar.Text = title or "Neptune AIO - Westbound"
    titleBar.TextColor3 = Color3.fromRGB(220, 220, 220)
    titleBar.Font = Enum.Font.GothamBold
    titleBar.TextSize = 24

    local tabContainer = Instance.new("Frame", main)
    tabContainer.Size = UDim2.new(0, 140, 1, -40)
    tabContainer.Position = UDim2.new(0, 0, 0, 40)
    tabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Instance.new("UICorner", tabContainer).CornerRadius = UDim.new(0, 8)
    Instance.new("UIListLayout", tabContainer).Padding = UDim.new(0, 6)

    local contentFrame = Instance.new("Frame", main)
    contentFrame.Size = UDim2.new(1, -150, 1, -50)
    contentFrame.Position = UDim2.new(0, 150, 0, 50)
    contentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    Instance.new("UICorner", contentFrame).CornerRadius = UDim.new(0, 8)

    local tabs = {}

    function NeptuneUI:Tab(name)
        local tabButton = Instance.new("TextButton", tabContainer)
        tabButton.Size = UDim2.new(1, -10, 0, 30)
        tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
        tabButton.Text = name
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextSize = 16
        Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0, 6)

        local tabFrame = Instance.new("Frame", contentFrame)
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false
        Instance.new("UIListLayout", tabFrame).Padding = UDim.new(0, 8)

        tabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(tabs) do
                t.Frame.Visible = false
                t.Button.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
            end
            tabFrame.Visible = true
            tabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        end)

        local tab = {
            Frame = tabFrame,
            Button = tabButton,
            Section = function(_, title)
                local sectionLabel = Instance.new("TextLabel", tabFrame)
                sectionLabel.Size = UDim2.new(1, -20, 0, 30)
                sectionLabel.Text = title
                sectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                sectionLabel.Font = Enum.Font.GothamBold
                sectionLabel.TextSize = 18
                sectionLabel.BackgroundTransparency = 1

                local section = {}

                function section:Label(text)
                    local label = Instance.new("TextLabel", tabFrame)
                    label.Size = UDim2.new(1, -20, 0, 24)
                    label.Text = text
                    label.TextColor3 = Color3.fromRGB(200, 200, 200)
                    label.Font = Enum.Font.Gotham
                    label.TextSize = 16
                    label.BackgroundTransparency = 1
                end

                function section:Button(text, callback)
                    local button = Instance.new("TextButton", tabFrame)
                    button.Size = UDim2.new(1, -20, 0, 30)
                    button.Text = text
                    button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    button.Font = Enum.Font.Gotham
                    button.TextSize = 16
                    button.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
                    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)
                    button.MouseButton1Click:Connect(callback)
                end

                function section:Toggle(text, callback)
                    local toggle = Instance.new("TextButton", tabFrame)
                    toggle.Size = UDim2.new(1, -20, 0, 30)
                    toggle.Text = text .. " [OFF]"
                    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    toggle.Font = Enum.Font.Gotham
                    toggle.TextSize = 16
                    toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 6)

                    local state = false
                    toggle.MouseButton1Click:Connect(function()
                        state = not state
                        toggle.Text = text .. (state and " [ON]" or " [OFF]")
                        callback(state)
                    end)
                end

                return section
            end
        }

        tabFrame.Parent = contentFrame
        table.insert(tabs, tab)
        return tab
    end

    return setmetatable(NeptuneUI, NeptuneUI)
end

-- Aimbot Logic
local function getClosestPlayer()
    local closest, distance = nil, math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
                if dist < distance then
                    closest = player
                    distance = dist
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if getgenv().AimbotEnabled then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
    end
end)

-- ESP Logic
RunService.RenderStepped:Connect(function()
    if getgenv().ESPEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                -- Add BillboardGui or Drawing API here
            end
        end
    end
end)

return NeptuneUI
