local UI = XyloUI.CreateWindow("Neptune AIO - Westbound")

-- Combat Tab
local combatTab = UI:Tab("Combat")
local combatSection = combatTab:Section("Aimbot")
combatSection:Toggle("Enable Aimbot", function(state)
    getgenv().AimbotEnabled = state
end)

combatSection:Button("Force Target", function()
    -- Example targeting logic
    local target = workspace:FindFirstChild("Bandit")
    if target then
        LocalPlayer.Character.Humanoid:MoveTo(target.Position)
    end
end)

-- ESP Tab
local espTab = UI:Tab("Visuals")
local espSection = espTab:Section("WallHack")
espSection:Toggle("Enable ESP", function(state)
    getgenv().ESPEnabled = state
end)

-- Utilities Tab
local utilTab = UI:Tab("Utilities")
local utilSection = utilTab:Section("Player Tools")
utilSection:Button("Reset Character", function()
    LocalPlayer.Character:BreakJoints()
end)

utilSection:Button("Set WalkSpeed to 100", function()
    LocalPlayer.Character.Humanoid.WalkSpeed = 100
end)

-- Branding Tab
local brandTab = UI:Tab("Made by Xylo 💻")
local brandSection = brandTab:Section("Neptune AIO")
brandSection:Label("This UI was custom-built by Xylo.")
brandSection:Label("Powered by Neptune AIO for Westbound.")
