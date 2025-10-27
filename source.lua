-- Load Luxware UI Library (rebranded as XyloUI)
local XyloUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Luxware-UI-Library/main/Source.lua"))()

-- Create main window
local DevWindow = XyloUI.CreateWindow("XyloUI Control Suite", 6105620301)

-- Apply custom theme
DevWindow:ChangeTheme({
    Background = Color3.fromRGB(20, 20, 25),
    Border = Color3.fromRGB(0, 255, 120),
    Accent = Color3.fromRGB(180, 0, 255),
    Text = Color3.fromRGB(230, 230, 230)
})

-- Tabs
local autoTab = DevWindow:Tab("Auto Engine", 6087485864)
local teleportTab = DevWindow:Tab("Teleport Hub")
local questTab = DevWindow:Tab("Quest System")
local combatTab = DevWindow:Tab("Combat Tools")
local showcaseTab = DevWindow:Tab("Showcase")
local brandingTab = DevWindow:Tab("Made by Xylo 💻")
local creditsTab = DevWindow:Tab("Credits")

-- Showcase Tab (FunUI-style widgets)
local section = showcaseTab:Section("FunUI Widgets")
section:Toggle("Toggle", function(s) print("Toggle:", s) end)
section:Button("Button", function() print("Button clicked") end)
section:Label("This is a label")
section:KeyBind("KeyBind (E)", Enum.KeyCode.E, function() print("KeyBind pressed") end)
section:Slider("Slider", 16, 200, function(val) print("Slider value:", val) end)
section:Dropdown("Dropdown", {"1", "2", "3"}, function(choice) print("Dropdown selected:", choice) end)
section:TextBox("Textbox", "Enter text...", function(text) print("Textbox input:", text) end)

-- Branding Tab
local xyloSection = brandingTab:Section("XyloUI Branding")
xyloSection:Label("This UI was custom-built by Xylo.")
xyloSection:Label("Combines Luxware and FunUI into one suite.")
xyloSection:Label("Designed for testing, automation, and control.")

-- Credits Tab
creditsTab:Section("Developer"):Credit("Xylo: Lead Developer")
creditsTab:Section("Frameworks"):Credit("xHeptc: Luxware & FunUI Libraries")
creditsTab:Section("Special Thanks"):Credit("Salad: Debug Assistance")

-- Placeholder Sections
autoTab:Section("Automation"):Label("Auto-Farm features coming soon")
teleportTab:Section("Teleport Options"):Label("Teleport destinations will be added here")
questTab:Section("Quest Automation"):Label("Auto-Quest system under development")
combatTab:Section("Combat Enhancements"):Label("Combat tools will be added here")

-- Optional: return the window object if needed
return DevWindow
