-- IZAYLENZ HUB | RAYFIELD EDITION + FLOATING 'L' BUTTON
task.spawn(function()
    local host = (gethui and gethui()) or game:GetService("CoreGui")
    if host:IsA("ScreenGui") then host = host.Parent or game:GetService("CoreGui") end
    if host:FindFirstChild("Rayfield") or game:GetService("CoreGui"):FindFirstChild("Rayfield") then return end

    local uRay = "https://sirius." .. "menu/rayfield"
    local ok, src = pcall(function() return game:HttpGet(uRay, true) end)
    if not ok or type(src) ~= "string" then return end

    local Rayfield = loadstring(src)()
    local Players, HttpService = game:GetService("Players"), game:GetService("HttpService")
    local LP = Players.LocalPlayer
    local genv = (getgenv and getgenv()) or _G
    genv.Config = {}

    local Window = Rayfield:CreateWindow({
        Name = "Izaylenz Hub | AOTR",
        LoadingTitle = "Izaylenz Hub",
        LoadingSubtitle = "Attack on Titan Revolution",
        ConfigurationSaving = { Enabled = true, FolderName = "IzaylenzHub", FileName = "AOTR_Config" }
    })

    -- Tombol Melayang Logo "L" (Buka/Tutup Menu di HP)
    pcall(function()
        if host:FindFirstChild("IzaylenzLogoL") then host.IzaylenzLogoL:Destroy() end
        local Gui = Instance.new("ScreenGui", host); Gui.Name = "IzaylenzLogoL"; Gui.ResetOnSpawn = false
        local Btn = Instance.new("TextButton", Gui)
        Btn.Size = UDim2.fromOffset(48, 48); Btn.Position = UDim2.new(0.05, 0, 0.25, 0)
        Btn.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Btn.TextColor3 = Color3.new(1, 1, 1)
        Btn.Text = "L"; Btn.Font = Enum.Font.GothamBlack; Btn.TextSize = 22; Btn.Draggable = true
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 12)
        local Stroke = Instance.new("UIStroke", Btn); Stroke.Color = Color3.fromRGB(90, 140, 255); Stroke.Thickness = 1.8

        Btn.MouseButton1Click:Connect(function()
            local rf = host:FindFirstChild("Rayfield") or game:GetService("CoreGui"):FindFirstChild("Rayfield")
            if rf then rf.Enabled = not rf.Enabled end
        end)
    end)

    -- TAB 1: MAIN FARM
    local MainTab = Window:CreateTab("Main Farm", 4483362458)
    MainTab:CreateSection("Farm Mode & Core")
    MainTab:CreateDropdown({ Name = "Select Farm Mode", Options = { "5 Second Missions", "1 Minute Raids" }, CurrentOption = { "5 Second Missions" }, Flag = "FarmMode", Callback = function(v) genv.Config.FarmMode = v end })
    MainTab:CreateToggle({ Name = "Enable Auto Farm", CurrentValue = false, Flag = "AutoFarm", Callback = function(v) genv.Config.AutoFarm = v end })
    MainTab:CreateSlider({ Name = "Auto Die at Streak", Range = {0, 100}, Increment = 1, CurrentValue = 0, Flag = "DieStreak", Callback = function(v) genv.Config.DieStreak = v end })

    MainTab:CreateSection("Extra Auto Farm")
    for _, f in ipairs({
        {"AutoObj", "Auto Build Watch Towers & Spear Supplies"}, {"SkipCutscene", "Auto Skip Cutscene"},
        {"OpenChests", "Auto Open Chests"}, {"AutoRetry", "Auto Retry"}, {"Failsafe", "Failsafe (Rejoin Main Menu if Stuck)"}
    }) do
        MainTab:CreateToggle({ Name = f[2], CurrentValue = false, Flag = f[1], Callback = function(v) genv.Config[f[1]] = v end })
    end

    -- TAB 2: SKILLS & RAID
    local SkillTab = Window:CreateTab("Skills & Raid", 4483362458)
    SkillTab:CreateSection("Auto Skills")
    for _, s in ipairs({
        {"Skill1", "Drill Thrust"}, {"Skill2", "Torrential Steel"}, {"Skill3", "Let it Rip"}, {"Skill4", "Rage Mode (Ackerman & Shiki)"}
    }) do
        SkillTab:CreateToggle({ Name = s[2], CurrentValue = false, Flag = s[1], Callback = function(v) genv.Config[s[1]] = v end })
    end

    SkillTab:CreateSection("Raid & Combat Boost")
    for _, r in ipairs({
        {"ThunderSpear", "Thunder Spear Support (Fast Raids)"}, {"ColossalRaid", "Colossal Raid Support"}, {"MultiHit", "Increased Hit Speed (Multi-Hit Perks)"}
    }) do
        SkillTab:CreateToggle({ Name = r[2], CurrentValue = false, Flag = r[1], Callback = function(v) genv.Config[r[1]] = v end })
    end

    -- TAB 3: AUTO START
    local StartTab = Window:CreateTab("Auto Start", 4483362458)
    StartTab:CreateSection("Mission & Raid Setup")
    StartTab:CreateDropdown({ Name = "Game Type", Options = { "Mission", "Raid", "Aberrant" }, CurrentOption = { "Mission" }, Flag = "GameType", Callback = function(v) genv.Config.GameType = v end })
    StartTab:CreateDropdown({ Name = "Map", Options = { "Shiganshina", "Trost", "Outskirts", "Giant Forest", "Utgard" }, CurrentOption = { "Shiganshina" }, Flag = "GameMap", Callback = function(v) genv.Config.GameMap = v end })
    StartTab:CreateDropdown({ Name = "Objective", Options = { "Skirmish", "Defend", "Escort", "Breach" }, CurrentOption = { "Skirmish" }, Flag = "GameObj", Callback = function(v) genv.Config.GameObj = v end })
    StartTab:CreateInput({ Name = "Modifiers", PlaceholderText = "No Perks, Injury...", RemoveTextAfterFocusLost = false, Callback = function(v) genv.Config.GameMod = v end })
    StartTab:CreateToggle({ Name = "Enable Auto Start Game", CurrentValue = false, Flag = "AutoStart", Callback = function(v) genv.Config.AutoStart = v end })

    StartTab:CreateSection("Thunder Spear Quests")
    StartTab:CreateToggle({ Name = "Auto Switch Map & Claim Spear Quests", CurrentValue = false, Flag = "SpearQuest", Callback = function(v) genv.Config.SpearQuest = v end })
    StartTab:CreateToggle({ Name = "Auto Equip Spears", CurrentValue = false, Flag = "EquipSpear", Callback = function(v) genv.Config.EquipSpear = v end })

    -- TAB 4: LOBBY & GEAR
    local LobbyTab = Window:CreateTab("Lobby & Gear", 4483362458)
    LobbyTab:CreateSection("Lobby Automation")
    for _, l in ipairs({
        {"Ret10", "Auto Return to Lobby every 10 Missions"}, {"UpgGear", "Auto Upgrade Gear (Blades & Spears)"},
        {"MaxTree", "Auto Max Skill Tree"}, {"EnhPerk", "Auto Enhance Perks"}, {"EqPerk", "Auto Equip Perks"},
        {"AutoPot", "Auto Buy & Use Potions"}, {"SelSlot", "Auto Select Slot"}
    }) do
        LobbyTab:CreateToggle({ Name = l[2], CurrentValue = false, Flag = l[1], Callback = function(v) genv.Config[l[1]] = v end })
    end

    LobbyTab:CreateSection("Prestige")
    LobbyTab:CreateToggle({ Name = "Auto Prestige at Max Level", CurrentValue = false, Flag = "AutoPres", Callback = function(v) genv.Config.AutoPres = v end })
    LobbyTab:CreateInput({ Name = "Minimum Gold to Prestige", PlaceholderText = "50000", RemoveTextAfterFocusLost = false, Callback = function(v) genv.Config.PresGold = tonumber(v) or 0 end })

    -- TAB 5: FAMILY & WEBHOOK
    local HookTab = Window:CreateTab("Family & Hook", 4483362458)
    HookTab:CreateSection("Family Roller")
    HookTab:CreateToggle({ Name = "Auto Family Roller", CurrentValue = false, Flag = "FamRoll", Callback = function(v) genv.Config.FamRoll = v end })
    HookTab:CreateToggle({ Name = "Mythical Family Webhook", CurrentValue = false, Flag = "MythHook", Callback = function(v) genv.Config.MythHook = v end })

    HookTab:CreateSection("Discord Webhook")
    HookTab:CreateInput({ Name = "Webhook URL", PlaceholderText = "https://discord.com...", RemoveTextAfterFocusLost = false, Callback = function(v) genv.Config.WebhookURL = v end })
    HookTab:CreateButton({ Name = "Test Webhook", Callback = function()
        local req = (syn and syn.request) or (fluxus and fluxus.request) or (delta and delta.request) or http_request or request
        local url = genv.Config.WebhookURL
        if req and type(url) == "string" and url:match("^https?://") then
            pcall(req, { Url = url, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = HttpService:JSONEncode({ content = "Izaylenz Hub Webhook Terhubung!" }) })
            Rayfield:Notify({ Title = "Webhook", Content = "Pesan terkirim ke Discord!", Duration = 3 })
        else
            Rayfield:Notify({ Title = "Webhook", Content = "Gagal! Cek URL Webhook.", Duration = 3 })
        end
    end })

    LP.Idled:Connect(function() local vu = game:GetService("VirtualUser"); vu:CaptureController(); vu:ClickButton2(Vector2.new()) end)
    Rayfield:LoadConfiguration()
end)
