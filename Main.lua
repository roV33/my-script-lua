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
_G.SenjataFarm = "Melee" -- Pilihan bawaan awal (Melee / Sword / Fruit)

local player = game.Players.LocalPlayer
local workspace = game:GetService("Workspace")
local virtualUser = game:GetService("VirtualUser")
local replicatedStorage = game:GetService("ReplicatedStorage")

player.Idled:Connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new(0,0))
end)

-- ====================================================================
-- FUNGSI PINTAR AUTOMATIC EQUIP WEAPON (Mendukung Melee, Sword, & Fruit)
-- ====================================================================
local function pegangSenjataOtomatis()
    local character = player.Character
    local backpack = player.Backpack
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if not (character and backpack and humanoid) then return end
    
    -- Cek apakah senjata yang dimaksud sudah dipegang di tangan agar tidak spam equip
    if character:FindFirstChild(_G.SenjataFarm) then return end
    
    -- JIKA PILIHANNYA ADALAH MELEE (Pukulan/Gaya Tarung)
    if _G.SenjataFarm == "Melee" then
        -- Mencari Combat, Black Leg, Electro, Fishman Kung Fu, dll.
        for _, tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Tooltip") and tool.Tooltip.Value == "Melee" then
                humanoid:EquipTool(tool)
                break
            end
        end
        
    -- JIKA PILIHANNYA ADALAH SWORD (Pedang)
    elseif _G.SenjataFarm == "Sword" then
        for _, tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Tooltip") and tool.Tooltip.Value == "Sword" then
                humanoid:EquipTool(tool)
                break
            end
        end
        
    -- JIKA PILIHANNYA ADALAH FRUIT (Buah Iblis - Only M1 Click)
    elseif _G.SenjataFarm == "Fruit" then
        for _, tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and (tool:FindFirstChild("Tooltip") and tool.Tooltip.Value == "Blox Fruit" or string.find(string.lower(tool.Name), "fruit")) then
                humanoid:EquipTool(tool)
                break
            end
        end
    end
end

-- ====================================================================
-- MESIN FAST ATTACK + KILL AURA (Mendukung Klik M1 Untuk Fruit)
-- ====================================================================
local function eksekusiKillAura()
    task.spawn(function()
        while _G.AutoFarmBloxFruits do
            task.wait(0.04) 
            
            local character = player.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            
            -- Mencari tool apa pun yang sedang dipegang karakter saat ini
            local weaponDipegang = character and character:FindFirstChildOfClass("Tool")
            
            if character and rootPart and weaponDipegang then
                local folderMusuh = workspace:FindFirstChild("Enemies") or workspace
                local daftarTarget = {}
                
                for _, npc in ipairs(folderMusuh:GetChildren()) do
                    if npc and npc.Parent and npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                        local npcRoot = npc:FindFirstChild("HumanoidRootPart")
                        if npcRoot and npcRoot.Parent then
                            local jarak = (npcRoot.Position - rootPart.Position).Magnitude
                            if jarak <= 25 then
                                table.insert(daftarTarget, npcRoot) 
                            end
                        end
                    end
                end
                
                -- EKSEKUSI SERANGAN
                if #daftarTarget > 0 then
                    -- JIKA PILIHANNYA FRUIT, MAKA WAJIB ONLY M1 CLICK (Simulasi Tap Layangan Delta)
                    if _G.SenjataFarm == "Fruit" then
                        virtualUser:CaptureController()
                        virtualUser:Button1Down(Vector2.new(0,0))
                    else
                        -- Jika Melee atau Sword, gunakan kombinasi remote event resmi biar kencang
                        local net = replicatedStorage:FindFirstChild("Modules") and replicatedStorage.Modules:FindFirstChild("Net")
                        if net then
                            net:RemoteEvent("Attack"):FireServer(daftarTarget)
                        else
                            virtualUser:CaptureController()
                            virtualUser:Button1Down(Vector2.new(0,0))
                        end
                    end
                end
            end
        end
    end)
end

-- ====================================================================
-- MESIN TELEPORTASI & FLIGHT ANCHOR
-- ====================================================================
local function jalankanFarmBlox()
    eksekusiKillAura()
    
    task.spawn(function()
        print("Sistem Pro Auto Farm Blox Fruits Aktif...")
        
        while _G.AutoFarmBloxFruits do
            task.wait(0.05) 
            
            local character = player.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            
            if character and rootPart and humanoid and humanoid.Health > 0 then
                local folderMusuh = workspace:FindFirstChild("Enemies") or workspace
                local targetMusuh = nil
                
                for _, npc in ipairs(folderMusuh:GetChildren()) do
                    if npc and npc.Parent and npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                        if npc:FindFirstChild("HumanoidRootPart") then
                            targetMusuh = npc
                            break
                        end
                    end
                end
                
                if targetMusuh and targetMusuh:FindFirstChild("HumanoidRootPart") then
                    local posisiNPC = targetMusuh.HumanoidRootPart.Position
                    
                    -- Panggil fungsi ganti senjata otomatis secara dinamis sesuai dropdown
                    pegangSenjataOtomatis()
                    
                    rootPart.Anchored = true
                    rootPart.CFrame = CFrame.new(posisiNPC + Vector3.new(0, 4, 0)) * CFrame.Angles(math.rad(-90), 0, 0)
                    
                    if targetMusuh:FindFirstChild("Humanoid") and targetMusuh.Humanoid.WalkSpeed > 0 then
                        targetMusuh.Humanoid.WalkSpeed = 0
                    end
                else
                    rootPart.Anchored = false
                end
            end
        end
        
        local character = player.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        if rootPart then rootPart.Anchored = false end
    end)
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


Tab:CreateSection("This Is a section, below is a divider")
Tab:CreateDivider()

local ConfigTab = Window:CreateTab({
        Name = "Config",
        Icon = "settings",
        ImageSource = "Material",
        ShowTitle = true
})

ConfigTab:BuildConfigSection()
