-- IZAYLENZ HUB | FIXED VERSION
local genv = (getgenv and getgenv()) or _G
if genv.IzaylenzHubRunning then return end
genv.IzaylenzHubRunning = true

local u1 = "https://github.com" .. "dawid-scripts/Fluent/releases/latest/download/main.lua"
local u2 = "https://githubusercontent.com" .. "dawid-scripts/Fluent/master/Addons/SaveManager.lua"

genv.Fluent = genv.Fluent or loadstring(game:HttpGet(u1, true))()
local Fluent = genv.Fluent
local SaveManager = loadstring(game:HttpGet(u2, true))()
local Players, HttpService = game:GetService("Players"), game:GetService("HttpService")
local LP = Players.LocalPlayer

local Window = Fluent:CreateWindow({
    Title = "Izaylenz Hub", SubTitle = "AOTR | Free Edition",
    TabWidth = 135, Size = UDim2.fromOffset(495, 335),
    Acrylic = false, Theme = "Darker", MinimizeKey = Enum.KeyCode.LeftControl
})

pcall(function()
    local host = (gethui and gethui()) or game:GetService("CoreGui")
    if host:IsA("ScreenGui") then host = host.Parent or game:GetService("CoreGui") end
    if host:FindFirstChild("IzaylenzBtn") then host.IzaylenzBtn:Destroy() end
    local Gui = Instance.new("ScreenGui", host); Gui.Name = "IzaylenzBtn"; Gui.ResetOnSpawn = false
    local Btn = Instance.new("TextButton", Gui)
    Btn.Size = UDim2.fromOffset(45, 45); Btn.Position = UDim2.new(0.04, 0, 0.2, 0)
    Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25); Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Text = "UI"; Btn.Font = Enum.Font.GothamBold; Btn.TextSize = 14; Btn.Draggable = true
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 10)
    Btn.MouseButton1Click:Connect(function() Window:Minimize() end)
end)

local Tabs = {
    Farm = Window:AddTab({ Title = "Auto Farm", Icon = "sword" }),
    Skills = Window:AddTab({ Title = "Auto Skills", Icon = "zap" }),
    AutoGame = Window:AddTab({ Title = "Auto Start", Icon = "play" }),
    Lobby = Window:AddTab({ Title = "Lobby & Gear", Icon = "shopping-bag" }),
    Family = Window:AddTab({ Title = "Family & Webhook", Icon = "users" }),
    Config = Window:AddTab({ Title = "Configs", Icon = "save" })
}
genv.Config = {}

local req = (syn and syn.request) or (fluxus and fluxus.request) or (delta and delta.request) or http_request or request
local function ReadStat(names)
    local ls, attrs = LP:FindFirstChild("leaderstats"), LP:GetAttributes()
    for _, n in ipairs(names) do
        if ls and ls:FindFirstChild(n) then return tonumber(tostring(ls[n].Value):match("%d+")) or 0 end
        if attrs[n] ~= nil then return tonumber(tostring(attrs[n]):match("%d+")) or 0 end
    end
    return 0
end

local function SendWebhook(title, desc)
    local url = genv.Config.WebhookURL
    if not req or type(url) ~= "string" or not url:match("^https?://") then return false end
    local payload = { embeds = {{
        title = title, description = desc, color = 11141375,
        fields = {
            { name = "Player", value = LP.Name, inline = true },
            { name = "Level", value = tostring(ReadStat({"Level", "Lv"})), inline = true },
            { name = "Stats", value = ReadStat({"Gold", "Coins"}) .. " Gold | " .. ReadStat({"Gems"}) .. " Gems", inline = false }
        },
        footer = { text = "Izaylenz Hub" }
    }}}
    return pcall(req, { Url = url, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = HttpService:JSONEncode(payload) })
end

Tabs.Farm:AddDropdown("FarmMode", { Title = "Farm Mode", Values = { "5 Second Missions", "1 Minute Raids" }, Default = 1, Callback = function(v) genv.Config.FarmMode = v end })
Tabs.Farm:AddToggle("AutoFarm", { Title = "Enable Auto Farm", Default = false, Callback = function(v) genv.Config.AutoFarm = v end })
for _, f in ipairs({
    {"AutoObj", "Auto Build Watch Towers & Spear Supplies"}, {"ThunderSpear", "Thunder Spear Support"},
    {"SkipCutscene", "Auto Skip Cutscene"}, {"OpenChests", "Auto Open Chests"}, {"ColossalRaid", "Colossal Raid Support"},
    {"MultiHit", "Increased Hit Speed (Multi-Hit)"}, {"AutoRetry", "Auto Retry"}, {"Failsafe", "Failsafe (Rejoin Main Menu if Stuck)"}
}) do Tabs.Farm:AddToggle(f[1], { Title = f[2], Default = false, Callback = function(v) genv.Config[f[1]] = v end }) end
Tabs.Farm:AddSlider("DieStreak", { Title = "Auto Die at Streak", Default = 0, Min = 0, Max = 100, Rounding = 0, Callback = function(v) genv.Config.DieStreak = v end })

for _, s in ipairs({
    {"Skill1", "Drill Thrust"}, {"Skill2", "Torrential Steel"}, {"Skill3", "Let it Rip"}, {"Skill4", "Rage Mode (Ackerman & Shiki)"}
}) do Tabs.Skills:AddToggle(s[1], { Title = s[2], Default = false, Callback = function(v) genv.Config[s[1]] = v end }) end

Tabs.AutoGame:AddDropdown("GameType", { Title = "Type", Values = { "Mission", "Raid", "Aberrant" }, Default = 1, Callback = function(v) genv.Config.GameType = v end })
Tabs.AutoGame:AddDropdown("GameMap", { Title = "Map", Values = { "Shiganshina", "Trost", "Outskirts", "Giant Forest", "Utgard" }, Default = 1, Callback = function(v) genv.Config.GameMap = v end })
Tabs.AutoGame:AddDropdown("GameObj", { Title = "Objective", Values = { "Skirmish", "Defend", "Escort", "Breach" }, Default = 1, Callback = function(v) genv.Config.GameObj = v end })
Tabs.AutoGame:AddInput("GameMod", { Title = "Modifiers", Default = "", Callback = function(v) genv.Config.GameMod = v end })
Tabs.AutoGame:AddToggle("AutoStart", { Title = "Enable Auto Start Game", Default = false, Callback = function(v) genv.Config.AutoStart = v end })
Tabs.AutoGame:AddToggle("SpearQuest", { Title = "Auto Switch Map & Claim Spear Quests", Default = false, Callback = function(v) genv.Config.SpearQuest = v end })
Tabs.AutoGame:AddToggle("EquipSpear", { Title = "Auto Equip Spears", Default = false, Callback = function(v) genv.Config.EquipSpear = v end })

for _, l in ipairs({
    {"Ret10", "Auto Return to Lobby every 10 Missions"}, {"UpgGear", "Auto Upgrade Gear (Blades & Spears)"},
    {"MaxTree", "Auto Max Skill Tree"}, {"EnhPerk", "Auto Enhance Perks"}, {"EqPerk", "Auto Equip Perks"},
    {"AutoPot", "Auto Buy & Use Potions"}, {"SelSlot", "Auto Select Slot"}
}) do Tabs.Lobby:AddToggle(l[1], { Title = l[2], Default = false, Callback = function(v) genv.Config[l[1]] = v end }) end
Tabs.Lobby:AddToggle("AutoPres", { Title = "Auto Prestige at Max Level", Default = false, Callback = function(v) genv.Config.AutoPres = v end })
Tabs.Lobby:AddInput("PresGold", { Title = "Gold to Prestige", Default = "50000", Numeric = true, Callback = function(v) genv.Config.PresGold = tonumber(v) or 0 end })

Tabs.Family:AddToggle("FamRoll", { Title = "Auto Family Roller", Default = false, Callback = function(v) genv.Config.FamRoll = v end })
Tabs.Family:AddInput("WebhookURL", { Title = "Discord Webhook URL", Default = "", Callback = function(v) genv.Config.WebhookURL = v end })
Tabs.Family:AddToggle("MythHook", { Title = "Mythical Family Webhook", Default = false, Callback = function(v) genv.Config.MythHook = v end })
Tabs.Family:AddButton({ Title = "Test Webhook", Callback = function()
    local ok = SendWebhook("Izaylenz Hub | Test", "Webhook berhasil terhubung!")
    Fluent:Notify({ Title = "Webhook", Content = ok and "Terkirim!" or "Gagal! Cek URL.", Duration = 3 })
end })

Tabs.Config:AddDropdown("CfgMode", { Title = "Config Mode", Values = { "Single", "Multi" }, Default = 1, Callback = function(v)
    SaveManager:SetFolder(v == "Multi" and ("Izaylenz_" .. LP.Name) or "Izaylenz_Global")
end })
SaveManager:SetLibrary(Fluent); SaveManager:IgnoreThemeSettings(); SaveManager:SetFolder("Izaylenz_Global"); SaveManager:BuildConfigSection(Tabs.Config)

LP.Idled:Connect(function() local vu = game:GetService("VirtualUser"); vu:CaptureController(); vu:ClickButton2(Vector2.new()) end)
Window:SelectTab(1); SaveManager:LoadAutoloadConfig()
Fluent:Notify({ Title = "Izaylenz Hub", Content = "Script berhasil dimuat!", Duration = 4 })
