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
_G.SenjataFarm = "Melee" -- Bawaan awal

local player = game.Players.LocalPlayer
local workspace = game:GetService("Workspace")
local virtualUser = game:GetService("VirtualUser")
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Anti-AFK Pelindung Disconnect
player.Idled:Connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new(0,0))
end)

local function pegangSenjataOtomatis()
    local character = player.Character
    local backpack = player.Backpack
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if not (character and backpack and humanoid) then return end
    
    -- Jika sudah megang senjata kustom di tangan, jangan di-spam
    local toolDipegang = character:FindFirstChildOfClass("Tool")
    if toolDipegang then
        local namaTool = string.lower(toolDipegang.Name)
        if _G.SenjataFarm == "Melee" and (string.find(namaTool, "combat") or string.find(namaTool, "leg") or string.find(namaTool, "style") or string.find(namaTool, "claw")) then return end
        if _G.SenjataFarm == "Sword" and not string.find(namaTool, "fruit") and not string.find(namaTool, "combat") then return end
        if _G.SenjataFarm == "Fruit" and string.find(namaTool, "fruit") then return end
    end
    
    -- Bongkar isi tas untuk equip sesuai pilihan dropdown
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local namaToolLow = string.lower(tool.Name)
            
            if _G.SenjataFarm == "Melee" then
                -- Mencari combat, dark step, electric, dll.
                if string.find(namaToolLow, "combat") or string.find(namaToolLow, "leg") or string.find(namaToolLow, "style") or string.find(namaToolLow, "claw") or string.find(namaToolLow, "fist") then
                    humanoid:EquipTool(tool)
                    break
                end
            elseif _G.SenjataFarm == "Sword" then
                -- Mengambil pedang apa pun yang bukan pukulan / bukan buah
                if not string.find(namaToolLow, "fruit") and not string.find(namaToolLow, "combat") then
                    humanoid:EquipTool(tool)
                    break
                end
            elseif _G.SenjataFarm == "Fruit" then
                -- Mengambil buah iblis yang bisa dipukul (M1)
                if string.find(namaToolLow, "fruit") then
                    humanoid:EquipTool(tool)
                    break
                end
            end
        end
    end
end

local function eksekusiKillAura()
    task.spawn(function()
        while _G.AutoFarmBloxFruits do
            task.wait(0.03) -- Kecepatan pukul stabil secepat kilat tanpa warning spam
            
            local character = player.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            local weaponDipegang = character and character:FindFirstChildOfClass("Tool")
            
            if character and rootPart and weaponDipegang then
                local folderMusuh = workspace:FindFirstChild("Enemies") or workspace
                local daftarTarget = {}
                
                for _, npc in ipairs(folderMusuh:GetChildren()) do
                    if npc and npc.Parent and npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                        local npcRoot = npc:FindFirstChild("HumanoidRootPart")
                        if npcRoot and npcRoot.Parent then
                            -- Jarak scan diperluas sedikit agar pas dengan ketinggian terbang baru
                            local jarak = (npcRoot.Position - rootPart.Position).Magnitude
                            if jarak <= 35 then
                                table.insert(daftarTarget, npcRoot) 
                            end
                        end
                    end
                end
                
                -- TEMBAK REGISTER DAMAGE KE SERVER
                if #daftarTarget > 0 then
                    -- Kirim paket data pukulan resmi biar kill aura berfungsi mutlak
                    local net = replicatedStorage:FindFirstChild("Modules") and replicatedStorage.Modules:FindFirstChild("Net")
                    if net then
                        net:RemoteEvent("Attack"):FireServer(daftarTarget)
                    end
                    
                    -- Simulasi klik M1 fisik agar buah/senjata memicu efek pukulan
                    virtualUser:CaptureController()
                    virtualUser:Button1Down(Vector2.new(0,0))
                end
            end
        end
    end)
end

local function jalankanFarmBlox()
    eksekusiKillAura()
    
    task.spawn(function()
        print("Sistem Penerbangan Kaku & Kill Aura Aktif...")
        
        while _G.AutoFarmBloxFruits do
            task.wait(0.02) -- Refresh posisi sangat cepat agar tidak goyang jatuh
            
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
                    
                    -- Keluarkan senjata pilihan dropdown ke tangan secara berkala
                    pegangSenjataOtomatis()
                    
                    -- KUNCI KARAKTER TOTAL (ANCHOR): Membuat karakter kaku melayang meluncur, anti-jatuh!
                    rootPart.Anchored = true
                    
                    -- POSISI BARU (8.5 STUDS DI ATAS KEPALA): Jarak aman mutlak agar NPC tidak bisa memukul balik!
                    rootPart.CFrame = CFrame.new(posisiNPC + Vector3.new(0, 8.5, 0)) * CFrame.Angles(math.rad(-90), 0, 0)
                    
                    -- Sedot musuh agar diam di area jangkauan Kill Aura
                    if targetMusuh:FindFirstChild("Humanoid") and targetMusuh.Humanoid.WalkSpeed > 0 then
                        targetMusuh.Humanoid.WalkSpeed = 0
                    end
                else
                    -- Jika musuh mati/belum muncul, matikan anchor sedetik agar gravitasi tidak glitch
                    rootPart.Anchored = false
                end
            end
        end
        
        -- Reset total tubuh saat tombol dimatikan ke [OFF]
        local character = player.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.Anchored = false 
        end
        print("Sistem Farm Dihentikan.")
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
