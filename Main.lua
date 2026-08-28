local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua",))()

local Window = Luna:CreateWindow({
	Name = "Colz Hub", 
	Subtitle = "-Blox Fruit", 
	LogoID = "119421651946103", 
	LoadingEnabled = true, 
	LoadingTitle = "welcome back", 
	LoadingSubtitle = "by R.O", 

		ConfigSettings = {
		RootFolder = "ColzHubData", 
		ConfigFolder = "Big Hub" 
	},

	KeySystem = true, 
	KeySettings = {
		Title = "CLZ Key",
		Subtitle = "Key System",
		Note = "This script no key but you need a complete linkvertise first",
		
		-- UBAH MENJADI 'true' AGAR KUNCI DISIMPAN DI DALAM ROOT FOLDER DI ATAS
		SaveInRoot = true, 
		
		SaveKey = true, 
		Key = {"FREEPERMKEY_?G=dyi2fha$@Gcn7"}, 
		SecondAction = {
			Enabled = true, 
			Type = "Link", 
			Parameter = "https://link-target.net" 
		}
	}

Window:CreateHomeTab({
        SupportedExecutors = {
                "Synapse X", "Krnl", "ProtoSmasher", "Fluxus", "Script-Ware",
                "EasyExploits", "Electron", "JJSploit", "Calamari", "SirHurt",
                "Sentinel", "WEAREDEVS", "Comet", "Cellery", "Wave", "CODex", "Delta"
        },
        DiscordInvite = "https://discord.gg/NjajtTbMK", 
        Icon = 1
})

Luna:Notification({
        Title = "Notification",
        Icon = "notifications_active",
        ImageSource = "Material",
        Content = "Thanks for using my script"
})

local Tab = Window:CreateTab({
        Name = "Tab Example",
        Icon = "view_in_ar",
        ImageSource = "Material",
        ShowTitle = true
})

Tab:CreateSection("main")  

-- A. Dropdown Pilihan Senjata
local WeaponDropdown = Tab:CreateDropdown({
    Name = "Pilih Senjata Farm",
    Description = nil,
    Options = {"Melee", "Sword", "Fruit"},
    CurrentOption = "Melee", 
    Callback = function(Option)
        _G.SenjataFarm = Option 
        print("Senjata farm diganti menjadi: " .. Option)
    end
})

-- B. Sakelar Toggle Auto Farm
local ToggleBlox = Tab:CreateToggle({
    Name = "Auto Farm + Kill Aura (Blox Fruits)",
    Description = "Otomatis ganti senjata pilihan dropdown + Flight Anchor",
    CurrentValue = false,
    Callback = function(State)
        _G.AutoFarmBloxFruits = State 
        
        if State then
            -- Memastikan fungsi pembantu dipanggil dengan aman jika sudah dideklarasikan di bawah
            if jalankanFarmBlox then
                jalankanFarmBlox()
            else
                print("Peringatan: Fungsi logika 'jalankanFarmBlox' belum dipasang di bawah skrip UI!")
            end
        else
            local character = game:GetService("Players").LocalPlayer.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            if rootPart then rootPart.Anchored = false end
        end
    end
})

Tab:CreateSection("ches farm")

local ToggleChes = Tab:CreateToggle({
	Name = "farm ches",
	Description = nil,
	CurrentValue = false,
    	Callback = function(Value)
       	    _G.FarmChestActive = Value
    	end
}, "ToggleChest") 

Tab:CreateSection("bone")

local ToggleBone = Tab:CreateToggle({
	Name = "farm bone",
	Description = nil,
	CurrentValue = false,
    	Callback = function(Value)
       	    _G.FarmBoneActive = Value
    	end
}, "ToggleBone") 

local Tab = Window:CreateTab({
	Name = "auto get item",
	Icon = "bot-message-square",
	ImageSource = "Material",
	ShowTitle = true 
})

TabItem:CreateSection("CDK")
TabItem:CreateDivider()

local ToggleTushita = TabItem:CreateToggle({
	Name = "auto tushita",
	Description = "get tushita",
	CurrentValue = false,
    	Callback = function(Value)
       	    _G.AutoTushitaActive = Value
    	end
}, "ToggleTushita")


function jalankanFarmBlox()
    -- Masukkan semua loop task.spawn() pergerakan, tween, auto quest, 
    -- dan remote attack m1 Anda di area bawah sini agar bisa membaca variabel 
    -- _G.AutoFarmBloxFruits dan _G.SenjataFarm dari UI di atas dengan lancar.
    print("Mesin Logika Auto Farm Berhasil Dipicu!")
end
