-- LENN HUB | 11-TAB FULL LAYOUT (Script.lua)
task.spawn(function()
    local u = "https://raw.githubusercontent." .. "com/lzaylenz-beep/Main.Lua/refs/heads/main/ui.lua"
    local Lib = loadstring(game:HttpGet(u, true))()
    local HS, Light, RS, LP = game:GetService("HttpService"), game:GetService("Lighting"), game:GetService("RunService"), game:GetService("Players").LocalPlayer
    local cfg = getgenv().Config

    -- 1. MAIN
    local t1 = Lib:Tab("Main")
    local t1L = t1.Left("Mission & Auto Start")
    t1L:Tog("Auto Farm Missions", "AutoFarmMissions"); t1L:Tog("Auto Retry", "AutoRetry"); t1L:Tog("Auto Start Next Game", "AutoStart")
    t1L:Drp("Type", {"Missions", "Raids", "Waves"}, "GameType"); t1L:Drp("Map", {"Shiganshina", "Trost", "Outskirts", "Giant Forest", "Utgard"}, "GameMap")
    t1L:Drp("Objective", {"Skirmish", "Defend", "Escort", "Breach"}, "GameObj"); t1L:Drp("Difficulty", {"Easy", "Normal", "Hard", "Severe", "Aberrant"}, "GameDiff")
    t1L:Inp("Modifiers...", "Modifiers")

    local t1R = t1.Right("Lobby & Actions")
    t1R:Tog("Auto Return to Lobby", "AutoReturnLobby"); t1R:Inp("Return After X Games (10)", "ReturnGames")
    t1R:Btn("Return to Lobby", function() end); t1R:Btn("Return to Main Menu", function() end)
    t1R:Btn("Check Shadow Ban", function() end); t1R:Btn("Join Discord", function() if setclipboard then setclipboard("https://discord.gg") end end)

    -- 2. COMBAT
    local t2 = Lib:Tab("Combat")
    local t2L = t2.Left("Combat Boost")
    t2L:Tog("Multi Hit (Up to 20)", "MultiHit"); t2L:Inp("Multi Hit Range (Studs)", "HitRange")
    t2L:Tog("Auto Reload / Refill", "AutoReload"); t2L:Tog("Auto Escape (Grabbed)", "AutoEscape"); t2L:Tog("Auto Use Skills", "AutoSkills")

    local t2R = t2.Right("Movement")
    t2R:Drp("Movement Mode", {"Hover", "Teleport"}, "MoveMode"); t2R:Inp("Hover Speed (Default: 200)", "HoverSpeed"); t2R:Inp("Float Height (Default: 18)", "FloatHeight")

    -- 3. AUTOMATION
    local t3 = Lib:Tab("Automation")
    local t3L = t3.Left("World & Chests")
    t3L:Tog("Auto Skip Cutscenes", "SkipCutscenes"); t3L:Tog("Auto Open Chests", "OpenChests"); t3L:Tog("Open Emperor Chest", "EmperorChest"); t3L:Tog("Delete Map", "DeleteMap")

    local t3R = t3.Right("Safety & Limits")
    t3R:Tog("Wait Before Last Titan/Boss", "WaitLastTitan"); t3R:Tog("Auto Execute", "AutoExecute"); t3R:Tog("Failsafe (Lobby if Stuck)", "Failsafe")
    t3R:Tog("Wait Before Farming", "WaitBeforeFarm"); t3R:Tog("Solo Only", "SoloOnly"); t3R:Inp("Die at Streak (0 = Off)", "DieStreak")

    -- 4. WAVES
    local t4 = Lib:Tab("Waves")
    local t4L = t4.Left("Wave Farming")
    t4L:Tog("Auto Farm Waves", "FarmWaves"); t4L:Tog("Auto Vote & Start Waves", "VoteWaves"); t4L:Inp("Return Lobby After X Waves", "WaveReturn"); t4L:Tog("Auto Collect Skills Crate", "CollectCrates")

    local t4R = t4.Right("Wave Economy")
    t4R:Tog("Upgrade Wave Gear", "WaveGear"); t4R:Drp("Base Upgrade", {"Max", "Refill", "Regen", "Replenish", "Revive"}, "BaseUpg")

    -- 5. PROGRESSION
    local t5 = Lib:Tab("Progression")
    local t5L = t5.Left("Gear & Perks")
    t5L:Tog("Upgrade Gear", "UpgradeGear"); t5L:Tog("Auto Enhance Perks", "EnhancePerks"); t5L:Inp("Perk Slot + Food Perk", "PerkSetup")

    local t5R = t5.Right("Skill Tree")
    t5R:Tog("Auto Skill Tree", "AutoSkillTree"); t5R:Drp("Priority Path", {"Offense", "Support", "Defense"}, "TreePath")

    -- 6. STATS
    local t6 = Lib:Tab("Stats")
    local t6L = t6.Left("Lifetime Tracking")
    t6L:Lbl("Kills: 0 | Games: 0"); t6L:Lbl("Farm Time: 00:00:00"); t6L:Lbl("Rewards: 0")

    local t6R = t6.Right("Stats Control")
    t6R:Btn("Save Stats", function() end); t6R:Btn("Load Stats", function() end); t6R:Btn("Reset Stats", function() end)

    -- 7. MARKET
    local t7 = Lib:Tab("Market")
    local t7L = t7.Left("Boosts & Spins")
    t7L:Tog("Auto Buy Boosts & Potions", "BuyBoosts"); t7L:Tog("Auto Buy Spins", "BuySpins"); t7L:Inp("Spin Pack + Amount", "SpinCfg")

    local t7R = t7.Right("Crates")
    t7R:Tog("Auto Buy Crates", "BuyCrates"); t7R:Tog("Auto Open Crates", "OpenCrates"); t7R:Inp("Crate Type + Amount", "CrateCfg")

    -- 8. THUNDER QUEST
    local t8 = Lib:Tab("Thunder Quest")
    local t8L = t8.Left("Spear Farming")
    t8L:Tog("Auto Thunder Spear Farm", "AutoSpearFarm")

    local t8R = t8.Right("Quest Automation")
    t8R:Tog("Full Quest Automation", "FullSpearQuest")

    -- 9. FAMILY
    local t9 = Lib:Tab("Family")
    local t9L = t9.Left("Family Roller")
    t9L:Tog("Auto Family Roll", "AutoFamilyRoll"); t9L:Drp("Stop When", {"Rarity", "Exact Rarity", "Named Families", "Max Rolls"}, "RollStop")
    t9L:Inp("Target Family / Max Rolls", "TargetFam"); t9L:Tog("Auto Store Family", "AutoStoreFam"); t9L:Tog("Keep Rolling", "KeepRolling"); t9L:Btn("Roll Once", function() end)

    local t9R = t9.Right("Slot, Prestige & Misc")
    t9R:Drp("Auto Select Slot", {"A", "B", "C"}, "SlotSelect"); t9R:Tog("Auto Prestige", "AutoPrestige"); t9R:Inp("Prestige Gold Trigger", "PrestigeGold")
    t9R:Tog("Use Boosts", "UseFamBoosts"); t9R:Tog("Auto Claim Achievements", "ClaimAchieve")

    -- 10. COSMETICS
    local t10 = Lib:Tab("Cosmetics")
    local t10L = t10.Left("Wear Cosmetic")
    t10L:Inp("Skin / Hat Name", "CosmeticName")

    local t10R = t10.Right("Auto Apply")
    t10R:Tog("Auto Reapply", "AutoReapplyCosm")

    -- 11. SETTINGS
    local t11 = Lib:Tab("Settings")
    local t11L = t11.Left("Discord Webhooks")
    t11L:Inp("Discord Webhook URL", "WebhookURL"); t11L:Tog("Reward Webhook", "RewardHook"); t11L:Tog("Mythical Family Webhook", "MythicFamHook"); t11L:Tog("Mythic Perk Ping", "MythicPerkPing")
    t11L:Btn("Test Webhook", function()
        local req = (syn and syn.request) or (fluxus and fluxus.request) or (delta and delta.request) or http_request or request
        local url = cfg.WebhookURL
        if req and type(url) == "string" and url:match("^https?://") then
            pcall(req, {Url = url, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = HS:JSONEncode({content = "LENN HUB Webhook Connected!"})})
        end
    end)

    local t11R = t11.Right("Performance & Visuals")
    t11R:Tog("Disable 3D Rendering", "No3D", function(v) pcall(function() RS:Set3dRenderingEnabled(not v) end) end)
    t11R:Tog("Remove Fog", "NoFog", function(v) Light.FogEnd = v and 100000 or 1000 end)
    t11R:Btn("Performance Mode (FPS Boost)", function()
        for _, o in ipairs(workspace:GetDescendants()) do if o:IsA("BasePart") then o.Material = Enum.Material.SmoothPlastic elseif o:IsA("Decal") or o:IsA("Texture") then o:Destroy() end end
    end)

    Lib:Init()
    LP.Idled:Connect(function() local vu = game:GetService("VirtualUser"); vu:CaptureController(); vu:ClickButton2(Vector2.new()) end)
end)
