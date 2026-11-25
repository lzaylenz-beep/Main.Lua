-- IZAYLENZ HUB | ANTI-STUCK MOBILE EDITION (ORION UI)
task.spawn(function()
    local genv = (getgenv and getgenv()) or _G
    if genv.IzaylenzRunning then return end
    genv.IzaylenzRunning = true

    local uOrion = "https://raw.githubusercontent." .. "com/jensonhirst/Orion/main/source"
    local ok, source = pcall(function() return game:HttpGet(uOrion, true) end)
    if not ok or type(source) ~= "string" then
        warn("[Izaylenz] Gagal mengunduh UI Library!")
        genv.IzaylenzRunning = false
        return
    end

    local OrionLib = loadstring(source)()
    local Players, HttpService = game:GetService("Players"), game:GetService("HttpService")
    local LP = Players.LocalPlayer

    local Window = OrionLib:MakeWindow({
        Name = "Izaylenz Hub | AOTR",
        HidePremium = true,
        SaveConfig = true,
        ConfigFolder = "IzaylenzHub",
        IntroEnabled = false -- Dimatikan agar langsung muncul tanpa freeze
    })

    genv.Config = {}

    -- Tab 1: Auto Farm
    local FarmTab = Window:MakeTab({ Name = "Auto Farm", Icon = "rbxassetid://4483345998" })
    FarmTab:AddDropdown({ Name = "Farm Mode", Default = "5 Second Missions", Options = { "5 Second Missions", "1 Minute Raids" }, Callback = function(v) genv.Config.FarmMode = v end })
    FarmTab:AddToggle({ Name = "Enable Auto Farm", Default = false, Callback = function(v) genv.Config.AutoFarm = v end })
    for _, name in ipairs({
        "Auto Build Watch Towers & Spear Supplies", "Thunder Spear Support", "Auto Skip Cutscene",
        "Auto Open Chests", "Colossal Raid Support", "Increased Hit Speed (Multi-Hit)",
        "Auto Retry", "Failsafe (Rejoin Main Menu if Stuck)"
    }) do
        FarmTab:AddToggle({ Name = name, Default = false, Callback = function(v) genv.Config[name] = v end })
    end
    FarmTab:AddSlider({ Name = "Auto Die at Streak", Min = 0, Max = 100, Default = 0, Increment = 1, Callback = function(v) genv.Config.DieStreak = v end })

    -- Tab 2: Auto Skills
    local SkillTab = Window:MakeTab({ Name = "Auto Skills", Icon = "rbxassetid://4483345998" })
    for _, sk in ipairs({ "Drill Thrust", "Torrential Steel", "Let it Rip", "Rage Mode (Ackerman & Shiki)" }) do
        SkillTab:AddToggle({ Name = sk, Default = false, Callback = function(v) genv.Config[sk] = v end })
    end

    -- Tab 3: Auto Start & Quests
    local StartTab = Window:MakeTab({ Name = "Auto Start", Icon = "rbxassetid://4483345998" })
    StartTab:AddDropdown({ Name = "Type", Default = "Mission", Options = { "Mission", "Raid", "Aberrant" }, Callback = function(v) genv.Config.GameType = v end })
    StartTab:AddDropdown({ Name = "Map", Default = "Shiganshina", Options = { "Shiganshina", "Trost", "Outskirts", "Giant Forest", "Utgard" }, Callback = function(v) genv.Config.GameMap = v end })
    StartTab:AddDropdown({ Name = "Objective", Default = "Skirmish", Options = { "Skirmish", "Defend", "Escort", "Breach" }, Callback = function(v) genv.Config.GameObj = v end })
    StartTab:AddTextbox({ Name = "Modifiers", Default = "", TextDisappear = false, Callback = function(v) genv.Config.GameMod = v end })
    StartTab:AddToggle({ Name = "Enable Auto Start Game", Default = false, Callback = function(v) genv.Config.AutoStart = v end })
    StartTab:AddToggle({ Name = "Auto Switch Map & Claim Spear Quests", Default = false, Callback = function(v) genv.Config.SpearQuest = v end })
    StartTab:AddToggle({ Name = "Auto Equip Spears", Default = false, Callback = function(v) genv.Config.EquipSpear = v end })

    -- Tab 4: Lobby
    local LobbyTab = Window:MakeTab({ Name = "Lobby & Gear", Icon = "rbxassetid://4483345998" })
    for _, lb in ipairs({
        "Auto Return to Lobby every 10 Missions", "Auto Upgrade Gear (Blades & Spears)", "Auto Max Skill Tree",
        "Auto Enhance Perks", "Auto Equip Perks", "Auto Buy & Use Potions", "Auto Select Slot", "Auto Prestige at Max Level"
    }) do
        LobbyTab:AddToggle({ Name = lb, Default = false, Callback = function(v) genv.Config[lb] = v end })
    end
    LobbyTab:AddTextbox({ Name = "Gold to Prestige", Default = "50000", TextDisappear = false, Callback = function(v) genv.Config.PresGold = tonumber(v) or 0 end })

    -- Tab 5: Family & Webhook
    local FamTab = Window:MakeTab({ Name = "Family & Webhook", Icon = "rbxassetid://4483345998" })
    FamTab:AddToggle({ Name = "Auto Family Roller", Default = false, Callback = function(v) genv.Config.FamRoll = v end })
    FamTab:AddTextbox({ Name = "Discord Webhook URL", Default = "", TextDisappear = false, Callback = function(v) genv.Config.WebhookURL = v end })
    FamTab:AddToggle({ Name = "Mythical Family Webhook", Default = false, Callback = function(v) genv.Config.MythHook = v end })
    FamTab:AddButton({ Name = "Test Webhook", Callback = function()
        local req = (syn and syn.request) or (fluxus and fluxus.request) or (delta and delta.request) or http_request or request
        local url = genv.Config.WebhookURL
        if req and type(url) == "string" and url:match("^https?://") then
            pcall(req, { Url = url, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = HttpService:JSONEncode({ content = "Izaylenz Hub Webhook Terhubung!" }) })
            OrionLib:MakeNotification({ Name = "Webhook", Content = "Pesan terkirim ke Discord!", Time = 3 })
        else
            OrionLib:MakeNotification({ Name = "Webhook", Content = "Gagal! Cek URL Webhook.", Time = 3 })
        end
    end })

    OrionLib:Init()
end)
