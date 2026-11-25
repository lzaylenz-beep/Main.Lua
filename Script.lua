-- IZAYLENZ HUB | TITANIC-STYLE UI + FLOATING 'L' BUTTON
task.spawn(function()
    local genv = (getgenv and getgenv()) or _G
    if genv.IzaylenzFluentRunning then return end
    genv.IzaylenzFluentRunning = true

    local uFluent = "https://github.com" .. "dawid-scripts/Fluent/releases/latest/download/main.lua"
    local uSave = "https://raw.githubusercontent." .. "com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"

    local ok, src = pcall(function() return game:HttpGet(uFluent, true) end)
    if not ok or type(src) ~= "string" then
        genv.IzaylenzFluentRunning = false
        return
    end

    local Fluent = loadstring(src)()
    local SaveManager = loadstring(game:HttpGet(uSave, true))()
    local Players, HttpService = game:GetService("Players"), game:GetService("HttpService")
    local LP = Players.LocalPlayer

    -- Jendela Gaya Titanic Hub
    local Window = Fluent:CreateWindow({
        Title = "Izaylenz Hub",
        SubTitle = "Attack on Titan Revolution",
        TabWidth = 140,
        Size = UDim2.fromOffset(510, 340),
        Acrylic = false, -- Ringan & anti-freeze di HP
        Theme = "Darker",
        MinimizeKey = Enum.KeyCode.LeftControl
    })

    -- Tombol Melayang Logo "L" (Untuk Buka/Tutup Menu di HP)
    pcall(function()
        local host = (gethui and gethui()) or game:GetService("CoreGui")
        if host:IsA("ScreenGui") then host = host.Parent or game:GetService("CoreGui") end
        if host:FindFirstChild("IzaylenzLogoL") then host.IzaylenzLogoL:Destroy() end

        local Gui = Instance.new("ScreenGui", host)
        Gui.Name = "IzaylenzLogoL"
        Gui.ResetOnSpawn = false

        local Btn = Instance.new("TextButton", Gui)
        Btn.Size = UDim2.fromOffset(48, 48)
        Btn.Position = UDim2.new(0.05, 0, 0.25, 0)
        Btn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.Text = "L"
        Btn.Font = Enum.Font.GothamBlack
        Btn.TextSize = 22
        Btn.Draggable = true

        local Corner = Instance.new("UICorner", Btn)
        Corner.CornerRadius = UDim.new(0, 12)

        local Stroke = Instance.new("UIStroke", Btn)
        Stroke.Color = Color3.fromRGB(90, 140, 255)
        Stroke.Thickness = 1.8

        Btn.MouseButton1Click:Connect(function()
            Window:Minimize()
        end)
    end)

    -- Tata Letak Tab Rapi ala Titanic Hub
    local Tabs = {
        Main = Window:AddTab({ Title = "Main Farm", Icon = "sword" }),
        Combat = Window:AddTab({ Title = "Skills & Raid", Icon = "zap" }),
        AutoStart = Window:AddTab({ Title = "Auto Start", Icon = "play" }),
        Lobby = Window:AddTab({ Title = "Lobby & Gear", Icon = "shopping-bag" }),
        Webhook = Window:AddTab({ Title = "Family & Hook", Icon = "users" }),
        Config = Window:AddTab({ Title = "Configs", Icon = "save" })
    }
    genv.Config = {}

    -- ================= TAB 1: MAIN FARM =================
    Tabs.Main:AddSection("Farm Mode & Core")
    Tabs.Main:AddDropdown("FarmMode", { Title = "Select Farm Mode", Values = { "5 Second Missions", "1 Minute Raids" }, Default = 1, Callback = function(v) genv.Config.FarmMode = v end })
    Tabs.Main:AddToggle("AutoFarm", { Title = "Enable Auto Farm", Default = false, Callback = function(v) genv.Config.AutoFarm = v end })
    Tabs.Main:AddSlider("DieStreak", { Title = "Auto Die at Streak (0 = Off)", Default = 0, Min = 0, Max = 100, Rounding = 0, Callback = function(v) genv.Config.DieStreak = v end })

    Tabs.Main:AddSection("Extra Auto Farm")
    for _, f in ipairs({
        {"AutoObj", "Auto Build Watch Towers & Spear Supplies"},
        {"SkipCutscene", "Auto Skip Cutscene"},
        {"OpenChests", "Auto Open Chests"},
        {"AutoRetry", "Auto Retry"},
        {"Failsafe", "Failsafe (Rejoin Main Menu if Stuck)"}
    }) do Tabs.Main:AddToggle(f[1], { Title = f[2], Default = false, Callback = function(v) genv.Config[f[1]] = v end }) end

    -- ================= TAB 2: SKILLS & RAID =================
    Tabs.Combat:AddSection("Auto Skills")
    for _, s in ipairs({
        {"Skill1", "Drill Thrust"}, {"Skill2", "Torrential Steel"}, {"Skill3", "Let it Rip"}, {"Skill4", "Rage Mode (Ackerman & Shiki)"}
    }) do Tabs.Combat:AddToggle(s[1], { Title = s[2], Default = false, Callback = function(v) genv.Config[s[1]] = v end }) end

    Tabs.Combat:AddSection("Raid & Combat Boost")
    for _, r in ipairs({
        {"ThunderSpear", "Thunder Spear Support (Fast Raids)"},
        {"ColossalRaid", "Colossal Raid Support"},
        {"MultiHit", "Increased Hit Speed (Multi-Hit Perks)"}
    }) do Tabs.Combat:AddToggle(r[1], { Title = r[2], Default = false, Callback = function(v) genv.Config[r[1]] = v end }) end

    -- ================= TAB 3: AUTO START =================
    Tabs.AutoStart:AddSection("Mission & Raid Setup")
    Tabs.AutoStart:AddDropdown("GameType", { Title = "Game Type", Values = { "Mission", "Raid", "Aberrant" }, Default = 1, Callback = function(v) genv.Config.GameType = v end })
    Tabs.AutoStart:AddDropdown("GameMap", { Title = "Map", Values = { "Shiganshina", "Trost", "Outskirts", "Giant Forest", "Utgard" }, Default = 1, Callback = function(v) genv.Config.GameMap = v end })
    Tabs.AutoStart:AddDropdown("GameObj", { Title = "Objective", Values = { "Skirmish", "Defend", "Escort", "Breach" }, Default = 1, Callback = function(v) genv.Config.GameObj = v end })
    Tabs.AutoStart:AddInput("GameMod", { Title = "Modifiers", Default = "", Placeholder = "No Perks, Injury...", Callback = function(v) genv.Config.GameMod = v end })
    Tabs.AutoStart:AddToggle("AutoStart", { Title = "Enable Auto Start Game", Default = false, Callback = function(v) genv.Config.AutoStart = v end })

    Tabs.AutoStart:AddSection("Thunder Spear Quests")
    Tabs.AutoStart:AddToggle("SpearQuest", { Title = "Auto Switch Map & Claim Spear Quests", Default = false, Callback = function(v) genv.Config.SpearQuest = v end })
    Tabs.AutoStart:AddToggle("EquipSpear", { Title = "Auto Equip Spears", Default = false, Callback = function(v) genv.Config.EquipSpear = v end })

    -- ================= TAB 4: LOBBY & GEAR =================
    Tabs.Lobby:AddSection("Lobby Automation")
    for _, l in ipairs({
        {"Ret10", "Auto Return to Lobby every 10 Missions"}, {"UpgGear", "Auto Upgrade Gear (Blades & Spears)"},
        {"MaxTree", "Auto Max Skill Tree"}, {"EnhPerk", "Auto Enhance Perks"}, {"EqPerk", "Auto Equip Perks"},
        {"AutoPot", "Auto Buy & Use Potions"}, {"SelSlot", "Auto Select Slot"}
    }) do Tabs.Lobby:AddToggle(l[1], { Title = l[2], Default = false, Callback = function(v) genv.Config[l[1]] = v end }) end

    Tabs.Lobby:AddSection("Prestige")
    Tabs.Lobby:AddToggle("AutoPres", { Title = "Auto Prestige at Max Level", Default = false, Callback = function(v) genv.Config.AutoPres = v end })
    Tabs.Lobby:AddInput("PresGold", { Title = "Minimum Gold to Prestige", Default = "50000", Numeric = true, Callback = function(v) genv.Config.PresGold = tonumber(v) or 0 end })

    -- ================= TAB 5: FAMILY & WEBHOOK =================
    Tabs.Webhook:AddSection("Family Roller")
    Tabs.Webhook:AddToggle("FamRoll", { Title = "Auto Family Roller", Default = false, Callback = function(v) genv.Config.FamRoll = v end })
    Tabs.Webhook:AddToggle("MythHook", { Title = "Mythical Family Webhook", Default = false, Callback = function(v) genv.Config.MythHook = v end })

    Tabs.Webhook:AddSection("Discord Webhook")
    Tabs.Webhook:AddInput("WebhookURL", { Title = "Webhook URL", Default = "", Placeholder = "https://discord.com...", Callback = function(v) genv.Config.WebhookURL = v end })
    Tabs.Webhook:AddButton({ Title = "Test Webhook", Callback = function()
        local req = (syn and syn.request) or (fluxus and fluxus.request) or (delta and delta.request) or http_request or request
        local url = genv.Config.WebhookURL
        if req and type(url) == "string" and url:match("^https?://") then
            pcall(req, { Url = url, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = HttpService:JSONEncode({ content = "Izaylenz Hub Webhook Terhubung!" }) })
            Fluent:Notify({ Title = "Webhook", Content = "Pesan terkirim ke Discord!", Duration = 3 })
        else
            Fluent:Notify({ Title = "Webhook", Content = "Gagal! Cek URL Webhook.", Duration = 3 })
        end
    end })

    -- ================= TAB 6: CONFIGS =================
    Tabs.Config:AddDropdown("CfgMode", { Title = "Config Mode (Single / Multi)", Values = { "Single", "Multi" }, Default = 1, Callback = function(v)
        SaveManager:SetFolder(v == "Multi" and ("Izaylenz_" .. LP.Name) or "Izaylenz_Global")
    end })
    SaveManager:SetLibrary(Fluent); SaveManager:IgnoreThemeSettings(); SaveManager:SetFolder("Izaylenz_Global"); SaveManager:BuildConfigSection(Tabs.Config)

    LP.Idled:Connect(function() local vu = game:GetService("VirtualUser"); vu:CaptureController(); vu:ClickButton2(Vector2.new()) end)
    Window:SelectTab(1); SaveManager:LoadAutoloadConfig()
    Fluent:Notify({ Title = "Izaylenz Hub", Content = "Ketuk tombol 'L' untuk buka/tutup menu!", Duration = 4 })
end)
