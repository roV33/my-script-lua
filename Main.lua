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

player.Idled:Connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new(0,0))
end)

local listPelindung = {}
setmetatable(listPelindung, { __index = function() return true end })
local list = listPelindung; local listKite = listPelindung

-- Data Siklus Quest Otomatis (Sea 1)
local function dapatkanDataQuest()
    local lvl = player.Data.Level.Value
    if lvl >= 0 and lvl < 10 then
        return "BanditQuest1", "Bandit", 1, CFrame.new(1059, 16, 1549)
    elseif lvl >= 10 and lvl < 15 then
        return "MonkeyQuest1", "Monkey", 1, CFrame.new(-1598, 36, 153)
    elseif lvl >= 15 and lvl < 30 then
        return "MonkeyQuest1", "Gorilla", 2, CFrame.new(-1598, 36, 153)
    elseif lvl >= 30 and lvl < 60 then
        return "PirateVillageQuest", "Pirate", 1, CFrame.new(-1140, 4, 3828)
    else
        return "BanditQuest1", "Bandit", 1, CFrame.new(1059, 16, 1549)
    end
end

-- Pergerakan Terbang Halus Tween Speed 300
local function lakukanTweenKe(targetCFrame)
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    local jarak = (rootPart.Position - targetCFrame.Position).Magnitude
    local kecepatan = 300 
    local durasi = jarak / kecepatan
    
    local infoTween = TweenInfo.new(durasi, Enum.EasingStyle.Linear)
    local terbang = tweenService:Create(rootPart, infoTween, {CFrame = targetCFrame})
    terbang:Play()
    terbang.Completed:Wait()
end

local function pegangSenjataOtomatis()
    local character = player.Character
    local backpack = player.Backpack
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not (character and backpack and humanoid) then return end
    
    -- Cek jika karakter sudah memegang tool di tangan agar tidak spam klik equip
    if character:FindFirstChildOfClass("Tool") then return end
    
    -- Memindai isi tas secara dinamis untuk mencocokkan tipe jenis senjata
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local cocok = false
            
            -- Mencari tipe berdasarkan folder bawaan skrip batin Blox Fruits
            local isFruit = string.find(string.lower(tool.Name), "fruit")
            local hasEquipEvent = tool:FindFirstChild("EquipEvent")
            
            if _G.SenjataFarm == "Melee" then
                -- Melee dicirikan memiliki properti pukulan atau bawaan awal pemain
                if hasEquipEvent and not isFruit and (string.find(string.lower(tool.Name), "combat") or string.find(string.lower(tool.Name), "style") or string.find(string.lower(tool.Name), "karate") or string.find(string.lower(tool.Name), "leg") or string.find(string.lower(tool.Name), "claw") or string.find(string.lower(tool.Name), "fist")) then
                    cocok = true
                end
            elseif _G.SenjataFarm == "Sword" then
                -- Sword adalah weapon yang bukan buah dan bukan gaya bertarung dasar
                if not isFruit and not string.find(string.lower(tool.Name), "combat") and not string.find(string.lower(tool.Name), "style") and not string.find(string.lower(tool.Name), "leg") then
                    cocok = true
                end
            elseif _G.SenjataFarm == "Fruit" then
                if isFruit then
                    cocok = true
                end
            end
            
            if cocok then
                humanoid:EquipTool(tool)
                -- Jalankan fungsi jabat tangan jaringan temuan Cobalt secara otomatis
                task.spawn(function()
                    local ev = tool:FindFirstChild("EquipEvent")
                    if ev then
                        ev:FireServer(true)
                    end
                end)
                break
            end
        end
    end
end

local function eksekusiKillAuraPro(namaTargetNPC)
    task.spawn(function()
        local netRemote = replicatedStorage:FindFirstChild("Modules") 
            and replicatedStorage.Modules:FindFirstChild("Net") 
            and replicatedStorage.Modules.Net:FindFirstChild("RE/RegisterAttack")
            
        while _G.AutoFarmBloxFruits do
            task.wait(0.01) 
            
            local character = player.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            local weapon = character and character:FindFirstChildOfClass("Tool")
            
            if character and rootPart and weapon and netRemote then
                local folderMusuh = workspace:FindFirstChild("Enemies") or workspace
                local adaMusuh = false
                
                for _, npc in ipairs(folderMusuh:GetChildren()) do
                    if string.find(string.lower(npc.Name), "boss") then continue end 
                    
                    if npc.Name == namaTargetNPC and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                        local npcRoot = npc:FindFirstChild("HumanoidRootPart")
                        if npcRoot and (npcRoot.Position - rootPart.Position).Magnitude <= 35 then
                            adaMusuh = true
                            
                            pcall(function()
                                netRemote:FireServer(0.40000000596046, 1)
                            end)
                        end
                    end
                end
                
                if adaMusuh then
                    pcall(function()
                        virtualUser:CaptureController()
                        virtualUser:Button1Down(Vector2.new(0,0))
                    end)
                end
            end
        end
    end)
end

local function jalankanFarmBlox()
    task.spawn(function()
        print("Sistem Auto Farm Universal Premium Aktif...")
        
        while _G.AutoFarmBloxFruits do
            task.wait(0.02)
            
            local character = player.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            
            if character and rootPart and humanoid and humanoid.Health > 0 then
                local namaQuest, namaNPC, idQuest, posNPCQuest = dapatkanDataQuest()
                local punyaQuest = player.PlayerGui.Main:FindFirstChild("Quest") and player.PlayerGui.Main.Quest.Visible
                
                for _, part in ipairs(character:GetChildren()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
                
                if not punyaQuest then
                    if rootPart:FindFirstChild("FarmVelocity") then rootPart.FarmVelocity:Destroy() end
                    lakukanTweenKe(posNPCQuest)
                    
                    task.wait(0.3)
                    replicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", namaQuest, idQuest)
                    task.wait(0.3)
                else
                    local folderMusuh = workspace:FindFirstChild("Enemies") or workspace
                    local targetMusuh = nil
                    
                    for _, npc in ipairs(folderMusuh:GetChildren()) do
                        if string.find(string.lower(npc.Name), "boss") then continue end 
                        
                        if npc.Name == namaNPC and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                            if npc:FindFirstChild("HumanoidRootPart") then
                                targetMusuh = npc
                                break
                            end
                        end
                    end
                    
                    if targetMusuh and targetMusuh:FindFirstChild("HumanoidRootPart") then
                        eksekusiKillAuraPro(namaNPC)
                        
                        local posisiNPC = targetMusuh.HumanoidRootPart.Position
                        pegangSenjataOtomatis()
                        
                        local farmBV = rootPart:FindFirstChild("FarmVelocity")
                        if not farmBV then
                            farmBV = Instance.new("BodyVelocity")
                            farmBV.Name = "FarmVelocity"
                            farmBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                            farmBV.Velocity = Vector3.new(0, 0, 0)
                            farmBV.Parent = rootPart
                        end
                        
                        rootPart.CFrame = CFrame.new(posisiNPC + Vector3.new(0, 10, 0)) * CFrame.Angles(math.rad(-90), 0, 0)
                        
                        if targetMusuh.Humanoid.WalkSpeed > 0 then targetMusuh.Humanoid.WalkSpeed = 0 end
                                                else
                                                        
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
