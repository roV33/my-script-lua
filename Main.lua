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

local function lakukanTweenKe(targetCFrame)
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    local jarak = (rootPart.Position - targetCFrame.Position).Magnitude
    local kecepatan = 300 -- Mengubah kecepatan meluncur menjadi 300 sesuai permintaanmu
    local durasi = jarak / kecepatan
    
    local infoTween = TweenInfo.new(durasi, Enum.EasingStyle.Linear)
    local terbang = tweenService:Create(rootPart, infoTween, {CFrame = targetCFrame})
    terbang:Play()
    terbang.Completed:Wait() -- Menunggu sampai mendarat tepat di titik koordinat tujuan
end

local function pegangSenjataOtomatis()
    local character = player.Character
    local backpack = player.Backpack
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not (character and backpack and humanoid) then return end
    
    local toolDipegang = character:FindFirstChildOfClass("Tool")
    if toolDipegang then
        local nameL = string.lower(toolDipegang.Name)
        if _G.SenjataFarm == "Melee" and (string.find(nameL, "combat") or string.find(nameL, "leg") or string.find(nameL, "style") or string.find(nameL, "claw")) then return end
        if _G.SenjataFarm == "Sword" and not string.find(nameL, "fruit") and not string.find(nameL, "combat") then return end
        if _G.SenjataFarm == "Fruit" and string.find(nameL, "fruit") then return end
    end
    
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local nameLow = string.lower(tool.Name)
            if _G.SenjataFarm == "Melee" and (string.find(nameLow, "combat") or string.find(nameLow, "leg") or string.find(nameLow, "style") or string.find(nameLow, "claw") or string.find(nameLow, "fist") or string.find(nameLow, "karate")) then
                humanoid:EquipTool(tool) break
            elseif _G.SenjataFarm == "Sword" and (not string.find(nameLow, "fruit") and not string.find(nameLow, "combat") and not string.find(nameLow, "leg") and not string.find(nameLow, "style")) then
                humanoid:EquipTool(tool) break
            elseif _G.SenjataFarm == "Fruit" and string.find(nameLow, "fruit") then
                humanoid:EquipTool(tool) break
            end
        end
    end
end


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
