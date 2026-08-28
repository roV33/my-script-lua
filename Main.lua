--[[https://github.com/Nebula-Softworks/Luna-Interface-Suite/blob/main/Documentation.md]]
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua", true))()

local Window = Luna:CreateWindow({
        Name = "Luna Example Window", -- This Is Title Of Your Window
        Subtitle = "A Gray Subtitle", -- A Gray Subtitle next To the main title.
        LogoID = "82795327169782", -- The Asset ID of your logo. Set to nil if you do not have a logo for Luna to use.
        LoadingEnabled = true, -- Whether to enable the loading animation. Set to false if you do not want the loading screen or have your own custom one.
        LoadingTitle = "Luna Interface Suite", -- Header for loading screen
        LoadingSubtitle = "by Nebula Softworks", -- Subtitle for loading screen

        ConfigSettings = {
                RootFolder = nil, -- The Root Folder Is Only If You Have A Hub With Multiple Game Scripts and u may remove it. DO NOT ADD A SLASH
                ConfigFolder = "Big Hub" -- The Name Of The Folder Where Luna Will Store Configs For This Script. DO NOT ADD A SLASH
        },

        KeySystem = true, -- As Of Beta 6, Luna Has officially Implemented A Key System!
        KeySettings = {
                Title = "Luna Example Key",
                Subtitle = "Key System",
                Note = "Best Key System Ever! Also, Please Use A HWID Keysystem like Pelican, Luarmor etc. that provide key strings based on your HWID since putting a simple string is very easy to bypass, the key is 1234!",
                SaveInRoot = false, -- Enabling will save the key in your RootFolder (YOU MUST HAVE ONE BEFORE ENABLING THIS OPTION)
                SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
                Key = {"1234"},
                SecondAction = {
                        Enabled = true,
                        Type = "Link", -- You can also put discord as an option, if your are doing that, don’t include discord.gg as Luna will auto add it as a prefix, just replace it with your identifier, example, if your are doing discord.gg/mspaint, just use mspaint.
                        Parameter = ""
                }
        }
})

Window:CreateHomeTab({
        SupportedExecutors = {
                "Synapse X",
                "Krnl",
                "ProtoSmasher",
                "Fluxus",
                "Script-Ware",
                "EasyExploits",
                "Electron",
                "JJSploit",
                "Calamari",
                "SirHurt",
                "Sentinel",
                "WEAREDEVS",
                "Comet",
                "Cellery",
                "Wave",
                "CODex",
                "Delta"
        },
        DiscordInvite = "1234", -- same thing here
        Icon = 1
})

local Tab = Window:CreateTab({
        Name = "Tab Example",
        Icon = "view_in_ar",
        ImageSource = "Material",
        ShowTitle = true
})

Luna:Notification({
        Title = "Luna Notification Example",
        Icon = "notifications_active",
        ImageSource = "Material",
        Content = "This Is A Preview Of Luna's Dynamic Notification System Entailing Estimated/Calculated Wait Times, A Sleek Design, Icons, And A Glassmorphic Look"
})

-- [[ CONFIGURATION & UTILITIES ]] --
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- Remote Events dari Cobalt yang Anda berikan
local AttackEvent = ReplicatedStorage.Modules.Net["RE/RegisterAttack"]

-- Database Quest dan Tingkatan Level (Contoh Struktur Data Leveling)
-- Anda bisa meneruskan daftar ini hingga Max Level 2800 sesuai dengan game data asli
local QuestData = {
    {MinLevel = 1,   MaxLevel = 10,  NPCName = "Bandit",       QuestName = "Bandits",       IslandPosition = Vector3.new(100, 20, 100)},
    {MinLevel = 10,  MaxLevel = 15,  NPCName = "Monkey",       QuestName = "Monkeys",       IslandPosition = Vector3.new(-1500, 30, 200)},
    {MinLevel = 15,  MaxLevel = 30,  NPCName = "Gorilla",      QuestName = "Gorillas",      IslandPosition = Vector3.new(-1200, 40, 300)},
    -- ... (Lewati ke contoh data level 600-650 seperti yang Anda instruksikan)
    {MinLevel = 575, MaxLevel = 625, NPCName = "Military Soldier", QuestName = "Military Soldiers", IslandPosition = Vector3.new(5000, 100, -2000)},
    {MinLevel = 625, MaxLevel = 650, NPCName = "Military Spy",     QuestName = "Military Spies",    IslandPosition = Vector3.new(5500, 120, -2200)},
}

-- Mengambil data quest yang sesuai dengan level karakter saat ini secara dinamis
local function GetCurrentQuest()
    local myLevel = LocalPlayer.Data.Level.Value
    -- Batasi looping farm maksimal di level 2800 sesuai permintaan Anda
    if myLevel >= 2800 then return nil end 
    
    for _, quest in ipairs(QuestData) do
        if myLevel >= quest.MinLevel and myLevel < quest.MaxLevel then
            return quest
        end
    end
    return QuestData[#QuestData] -- Mengembalikan data terakhir jika tidak ada kecocokan
end

-- [[ AUTO EQUIP WEAPON DYNAMIC ]] --
-- Fitur ini otomatis mencari senjata/fighting style apa saja yang tersedia di Inventory dan memasangnya
local function AutoEquipWeapon()
    local Character = LocalPlayer.Character
    local Backpack = LocalPlayer.Backpack
    
    if Character and Backpack then
        -- Cek apakah sudah ada senjata yang digenggam di karakter
        local currentTool = Character:FindFirstChildOfClass("Tool")
        if not currentTool then
            -- Cari item pertama yang tersedia di Backpack (Bisa Fighting Style, Sword, atau Fruit)
            local targetTool = Backpack:FindFirstChildOfClass("Tool")
            if targetTool then
                targetTool.Parent = Character
                
                -- Jika item tersebut memiliki EquipEvent bawaan, tembak servernya secara otomatis
                if targetTool:FindFirstChild("EquipEvent") then
                    targetTool.EquipEvent:FireServer(true)
                end
            end
        end
    end
end

-- [[ TWEEN TWEEN MOVEMENT (SPEED 300) ]] --
local function TweenToPosition(targetCFrame)
    local Character = LocalPlayer.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = Character.HumanoidRootPart
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local speed = 300 -- Menggunakan kecepatan 300 sesuai permintaan Anda
    local duration = distance / speed
    
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
    
    tween:Play()
    return tween
end

-- [[ INTEGRASI AUTO QUEST ]] --
local function CheckAndTakeQuest(questName)
    -- Logika integrasi: Cek apakah data quest aktif di UI/Data player sudah ada atau belum
    -- Jika belum ada quest aktif, tembak Remote Event Quest bawaan game
    local hasQuest = LocalPlayer.PlayerGui:FindFirstChild("Main") and LocalPlayer.PlayerGui.Main:FindFirstChild("Quest")
    if hasQuest and not hasQuest.Visible then
        -- Eksekusi pengambilan quest melalui remote event utama game Blox Fruit
        -- (Ganti "ReplicatedStorage.RemoteEventQuest" dengan path remote quest real jika berbeda)
        local QuestEvent = ReplicatedStorage:FindFirstChild("QuestService") or ReplicatedStorage.Modules.Net["RE/QuestController"]
        if QuestEvent then
            QuestEvent:FireServer("StartQuest", questName, 1)
        end
    end
end

-- [[ FAST ATTACK & COMBAT LOGIC ]] --
local function FastAttack(targetNPC)
    -- Fitur pembatasan hit sekali m1 dan bypass cooldown (Fast Attack)
    task.spawn(function()
        if targetNPC and targetNPC:FindFirstChild("Humanoid") and targetNPC.Humanoid.Health > 0 then
            -- M1 attack dilakukan sekali per pemicuan di atas musuh
            AttackEvent:FireServer(0.40000000596046, 1)
            
            -- Menyerang bagian hitbox target jika sistem membutuhkan Hit Register tambahan
            local RegisterHit = ReplicatedStorage.Modules.Net:FindFirstChild("RE/RegisterHit")
            if RegisterHit and targetNPC:FindFirstChild("HumanoidRootPart") then
                RegisterHit:FireServer(targetNPC.HumanoidRootPart)
            end
        end
    end)
end

-- [[ CORE LOOP AUTO FARM ]] --
task.spawn(function()
    while task.wait() do
        pcall(function()
            local currentQuest = GetCurrentQuest()
            if not currentQuest then return end
            
            -- 1. Jalankan Auto Equip Senjata secara konstan
            AutoEquipWeapon()
            
            -- 2. Ambil Quest Terlebih Dahulu
            CheckAndTakeQuest(currentQuest.QuestName)
            
            -- 3. Cari Target NPC yang spesifik sesuai dengan Quest Level saat ini
            local targetNPC = nil
            for _, npc in ipairs(workspace.Enemies:GetChildren()) do
                if npc.Name == currentQuest.NPCName and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                    targetNPC = npc
                    break
                end
            end
            
            -- 4. Logika Pergerakan Posisi dan Penyerangan Musuh
            if targetNPC and targetNPC:FindFirstChild("HumanoidRootPart") then
                -- Atur posisi Karakter tepat berada di ATAS NPC sejauh 14 Studs agar aman dari hit musuh
                local npcPos = targetNPC.HumanoidRootPart.Position
                local safeStanceCFrame = CFrame.new(npcPos.X, npcPos.Y + 14, npcPos.Z) * CFrame.Angles(math.rad(-90), 0, 0)
                
                -- Pindah ke posisi target menggunakan Tween Speed 300
                TweenToPosition(safeStanceCFrame)
                
                -- Lakukan Fast Attack sekali M1 secara simultan saat berada di jangkauan musuh
                FastAttack(targetNPC)
            else
                -- Jika NPC belum spawn di map, diam/berdiri di pulau tempat spawn NPC tersebut
                local islandAirspace = CFrame.new(currentQuest.IslandPosition.X, currentQuest.IslandPosition.Y + 50, currentQuest.IslandPosition.Z)
                TweenToPosition(islandAirspace)
            end
        end)
    end
end)
                                                     
-- A. MEMBUAT DROPDOWN PILIHAN SENJATA DI LUNA UI
local WeaponDropdown = Tab:CreateDropdown({
    Name = "Pilih Senjata Farm",
    Description = "Pilih jenis senjata sebelum menyalakan Auto Farm",
    Options = {"Melee", "Sword", "Fruit"},
    CurrentOption = "Melee", -- Bawaan awal memilih Melee
    Callback = function(Option)
        _G.SenjataFarm = Option -- Mengubah target tipe senjata secara langsung saat diklik
        print("Senjata farm diganti menjadi: " .. Option)
    end
})

-- B. MEMBUAT SAKELAR TOGGLE AUTO FARM
local ToggleBlox = Tab:CreateToggle({
    Name = "Auto Farm + Kill Aura (Blox Fruits)",
    Description = "Otomatis ganti senjata pilihan dropdown + Flight Anchor",
    CurrentValue = false,
    Callback = function(State)
        _G.AutoFarmBloxFruits = State 
        
        if State then
            jalankanFarmBlox() 
        else
            local character = player.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            if rootPart then rootPart.Anchored = false end
        end
    end
})


Tab:CreateSection("COOMING SOON")
Tab:CreateDivider()

local ConfigTab = Window:CreateTab({
        Name = "Config",
        Icon = "settings",
        ImageSource = "Material",
        ShowTitle = true
})

ConfigTab:BuildConfigSection()
