-- XyloUI: Custom Rebrand of Luxware
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local XyloUI = {}
XyloUI.__index = XyloUI

function XyloUI.CreateWindow(title, logoId)
    local screenGui = Instance.new("ScreenGui", game.CoreGui)
    screenGui.Name = "XyloUI"
    screenGui.ResetOnSpawn = false

    -- Main Frame
    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Size = UDim2.new(0, 500, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.BorderSizePixel = 0

    local corner = Instance.new("UICorner", mainFrame)
    corner.CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke", mainFrame)
    stroke.Color = Color3.fromRGB(0, 255, 120)
    stroke.Thickness = 2

    -- Logo
    local logo = Instance.new("ImageLabel", mainFrame)
    logo.Size = UDim2.new(0, 100, 0, 100)
    logo.Position = UDim2.new(0.5, -50, 0, -60)
    logo.BackgroundTransparency = 1
    logo.Image = "rbxassetid://15661922687" -- Your custom XyloUI logo

    -- Title
    local titleLabel = Instance.new("TextLabel", mainFrame)
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.Position = UDim2.new(0, 0, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "XyloUI Control Suite"
    titleLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 24

    -- Tab Container
    local tabContainer = Instance.new("Frame", mainFrame)
    tabContainer.Size = UDim2.new(0, 120, 1, -60)
    tabContainer.Position = UDim2.new(0, 0, 0, 60)
    tabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    Instance.new("UICorner", tabContainer).CornerRadius = UDim.new(0, 8)

    local tabLayout = Instance.new("UIListLayout", tabContainer)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 6)

    -- Content Frame
    local contentFrame = Instance.new("Frame", mainFrame)
    contentFrame.Size = UDim2.new(1, -140, 1, -60)
    contentFrame.Position = UDim2.new(0, 130, 0, 60)
    contentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Instance.new("UICorner", contentFrame).CornerRadius = UDim.new(0, 8)

    local contentLayout = Instance.new("UIListLayout", contentFrame)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 10)

    local tabs = {}

    function XyloUI:Tab(name)
        local tabButton = Instance.new("TextButton", tabContainer)
        tabButton.Size = UDim2.new(1, -10, 0, 30)
        tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        tabButton.Text = name
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextSize = 16
        Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0, 6)

        local tabFrame = Instance.new("Frame")
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false
        tabFrame.Parent = contentFrame

        local layout = Instance.new("UIListLayout", tabFrame)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 8)

        tabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(tabs) do
                t.Frame.Visible = false
                t.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            end
            tabFrame.Visible = true
            tabButton.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
        end)

        local tab = {
            Frame = tabFrame,
            Button = tabButton,
            Section = function(self, title)
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
                    button.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
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

        table.insert(tabs, tab)
        return tab
    end

    return setmetatable(XyloUI, XyloUI)
end

return XyloUI
