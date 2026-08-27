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
_G.AutoFarmBloxFruits = false
_G.SenjataFarm = "Melee" 

local player = game.Players.LocalPlayer
local workspace = game:GetService("Workspace")
local virtualUser = game:GetService("VirtualUser")
local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")

-- Sistem Anti-AFK agar Delta tidak DC saat ditinggal tidur/sekolah
player.Idled:Connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new(0,0))
end)

-- Pustaka Pengaman agar UI Lama kamu tidak memicu error index nil
local listPelindung = {}
setmetatable(listPelindung, { __index = function() return true end })
local list = listPelindung; local listKite = listPelindung

-- ====================================================================
-- DATA PINTAR SIKLUS QUEST (Sea 1 Otomatis - Anti-Boss Filter)
-- ====================================================================
local function dapatkanDataQuest()
    local lvl = player.Data.Level.Value
    if lvl >= 0 and lvl < 10 then
        return "BanditQuest1", "Bandit", 1, CFrame.new(1059, 16, 1549)
    elseif lvl >= 10 and lvl < 15 then
        return "MonkeyQuest1", "Monkey", 1, CFrame.new(-1598, 36, 153)
    elseif lvl >= 15 and lvl < 30 then
        return "MonkeyQuest1", "Gorilla", 2, CFrame.new(-1598, 36, 153) -- Mengabaikan Boss Gorilla King
    elseif lvl >= 30 and lvl < 60 then
        return "PirateVillageQuest", "Pirate", 1, CFrame.new(-1140, 4, 3828)
    else
        return "BanditQuest1", "Bandit", 1, CFrame.new(1059, 16, 1549)
    end
end

-- ====================================================================
-- TWEEN ENGINE SPEED 300 CONSTANT (Pergerakan Terbang Halus Tidak Kaku)
-- ====================================================================
local function lakukanTweenKe(targetCFrame)
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    local jarak = (rootPart.Position - targetCFrame.Position).Magnitude
    local kecepatan = 300 -- Kecepatan kilat 300 studs/detik sesuai permintaanmu
    local durasi = jarak / kecepatan
    
    local infoTween = TweenInfo.new(durasi, Enum.EasingStyle.Linear)
    local terbang = tweenService:Create(rootPart, infoTween, {CFrame = targetCFrame})
    terbang:Play()
    terbang.Completed:Wait()
end

-- ====================================================================
-- SAKELAR AUTO EQUIP WEAPON (Mendukung Melee, Sword, Fruit)
-- ====================================================================
local function pegangSenjataOtomatis()
    local character = player.Character
    local backpack = player.Backpack
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not (character and backpack and humanoid) then return end
    
    local toolDipegang = character:FindFirstChildOfClass("Tool")
    if toolDipegang then
        local nameL = string.lower(toolDipegang.Name)
        if _G.SenjataFarm == "Melee" and (string.find(nameL, "combat") or string.find(nameL, "leg") or string.find(nameL, "style")) then return end
        if _G.SenjataFarm == "Sword" and not string.find(nameL, "fruit") and not string.find(nameL, "combat") then return end
        if _G.SenjataFarm == "Fruit" and string.find(nameL, "fruit") then return end
    end
    
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local nameLow = string.lower(tool.Name)
            if _G.SenjataFarm == "Melee" and (string.find(nameLow, "combat") or string.find(nameLow, "leg") or string.find(nameLow, "style") or string.find(nameLow, "claw")) then
                humanoid:EquipTool(tool) break
            elseif _G.SenjataFarm == "Sword" and (not string.find(nameLow, "fruit") and not string.find(nameLow, "combat") and not string.find(nameLow, "leg")) then
                humanoid:EquipTool(tool) break
            elseif _G.SenjataFarm == "Fruit" and string.find(nameLow, "fruit") then
                humanoid:EquipTool(tool) break
            end
        end
    end
end

-- ====================================================================
-- REAL SPAMMING M1 ATTACK (Memicu Kill Aura Fisika Tanpa Jeda)
-- ====================================================================
local function eksekusiM1Spam()
    task.spawn(function()
        while _G.AutoFarmBloxFruits do
            -- Jeda 0.01 detik untuk simulasi spam jari tercepat (Bypass Anti-Cheat & 119 Warnings)
            task.wait(0.01) 
            
            local character = player.Character
            local weapon = character and character:FindFirstChildOfClass("Tool")
            
            if character and weapon then
                -- Menembakkan trigger ayunan pukulan fisik (M1) dari client ke server game
                pcall(function()
                    virtualUser:CaptureController()
                    virtualUser:Button1Down(Vector2.new(0,0))
                    
                    -- Injeksi framework animasi serang lokal agar damage terdaftar
                    local combatFramework = require(player.PlayerScripts.CombatFramework)
                    if combatFramework and combatFramework.CombatRigController and combatFramework.CombatRigController.activeController then
                        combatFramework.CombatRigController.activeController:attack()
                    end
                end)
            end
        end
    end)
end

-- ====================================================================
-- CORE LOOP: NOCLIP FLY ENGINE + AUTO QUEST MANAGER
-- ====================================================================
local function jalankanFarmBlox()
    -- Aktifkan sistem spam pukulan kilat (Kill Aura M1) di background
    eksekusiM1Spam()
    
    task.spawn(function()
        print("Sistem Premium Auto Quest & Noclip Fly Aktif...")
        
        while _G.AutoFarmBloxFruits do
            task.wait(0.02)
            
            local character = player.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            
            if character and rootPart and humanoid and humanoid.Health > 0 then
                local namaQuest, namaNPC, idQuest, posNPCQuest = dapatkanDataQuest()
                local punyaQuest = player.PlayerGui.Main:FindFirstChild("Quest") and player.PlayerGui.Main.Quest.Visible
                
                -- Aktifkan mode tembus dinding (Noclip) agar pergerakan terbang tidak sangkut di pulau
                for _, part in ipairs(character:GetChildren()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
                
                if not punyaQuest then
                    -- JIKA AMBIL QUEST: Bersihkan gaya apung terbang, lalu Tween meluncur halus (Speed 300)
                    if rootPart:FindFirstChild("FarmVelocity") then rootPart.FarmVelocity:Destroy() end
                    lakukanTweenKe(posNPCQuest)
                    
                    task.wait(0.2)
                    replicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", namaQuest, idQuest)
                    task.wait(0.2)
                else
                    -- JIKA BERBURU NPC: Cari target NPC Biasa (Abaikan Boss)
                    local folderMusuh = workspace:FindFirstChild("Enemies") or workspace
                    local targetMusuh = nil
                    
                    for _, npc in ipairs(folderMusuh:GetChildren()) do
                        -- Saringan Ketat: Lewati jika objek adalah BOSS berdarah tebal
                        if string.find(string.lower(npc.Name), "boss") then continue end
                        
                        if npc.Name == namaNPC and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                            if npc:FindFirstChild("HumanoidRootPart") then
                                targetMusuh = npc
                                break
                            end
                        end
                    end
                    
                    if targetMusuh and targetMusuh:FindFirstChild("HumanoidRootPart") then
                        local posisiNPC = targetMusuh.HumanoidRootPart.Position
                        
                        pegangSenjataOtomatis()
                        
                        -- GAYA TERBANG PREMIUM (NOCLIP GYRO ENGINE): Membuat karakter melayang mulus tidak kaku
                        local farmBV = rootPart:FindFirstChild("FarmVelocity")
                        if not farmBV then
                            farmBV = Instance.new("BodyVelocity")
                            farmBV.Name = "FarmVelocity"
                            farmBV.MaxForce = Vector3.new(9e9, 9e9, 9e9) -- Menghapus efek gravitasi total
                            farmBV.Velocity = Vector3.new(0, 0, 0) -- Menjaga posisi stabil melayang
                            farmBV.Parent = rootPart
                        end
                        
                        -- SET JARAK AMAN 10 STUDS: Sesuai saran jitu kamu, melayang pas 10 studs di atas NPC (NPC Anti-Hit)
                        rootPart.CFrame = CFrame.new(posisiNPC + Vector3.new(0, 10, 0)) * CFrame.Angles(math.rad(-90), 0, 0)
                        
                        -- Sedot musuh agar diam berkumpul menerima damage M1 Spam
                        if targetMusuh.Humanoid.WalkSpeed > 0 then targetMusuh.Humanoid.WalkSpeed = 0 end
                    else
                        -- Jika monster area mati/belum muncul, meluncur datangi koordinat spawn utamanya
                        if rootPart:FindFirstChild("FarmVelocity") then rootPart.FarmVelocity:Destroy() end

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
