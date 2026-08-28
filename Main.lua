local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua", true))()

local Window = Luna:CreateWindow({
	Name = "Colz Hub", -- This Is Title Of Your Window
	Subtitle = "-Blox Fruit", -- A Gray Subtitle next To the main title.
	LogoID = "82795327169782", -- The Asset ID of your logo. Set to nil if you do not have a logo for Luna to use.
	LoadingEnabled = true, -- Whether to enable the loading animation. Set to false if you do not want the loading screen or have your own custom one.
	LoadingTitle = "welcome back", -- Header for loading screen
	LoadingSubtitle = "by R.O", -- Subtitle for loading screen

	ConfigSettings = {
		RootFolder = nil, -- The Root Folder Is Only If You Have A Hub With Multiple Game Scripts and u may remove it. DO NOT ADD A SLASH
		ConfigFolder = "Big Hub" -- The Name Of The Folder Where Luna Will Store Configs For This Script. DO NOT ADD A SLASH
	},

	KeySystem = true, -- As Of Beta 6, Luna Has officially Implemented A Key System!
	KeySettings = {
		Title = "CLZ Key",
		Subtitle = "Key System",
		Note = "This script no key but you need a complete linkvertise first",
		SaveInRoot = false, -- Enabling will save the key in your RootFolder (YOU MUST HAVE ONE BEFORE ENABLING THIS OPTION)
		SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		Key = {"FREEPERMKEY_?G=dyi2fha$@Gcn7"}, -- List of keys that will be accepted by the system, please use a system like Pelican or Luarmor that provide key strings based on your HWID since putting a simple string is very easy to bypass
		SecondAction = {
			Enabled = true, -- Set to false if you do not want a second action,
			Type = "Link", -- Link / Discord.
			Parameter = "https://link-target.net/8760278/VE5HlA1QgkWi" -- If Type is Discord, then put your invite link (DO NOT PUT DISCORD.GG/). Else, put the full link of your key system here.
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
        DiscordInvite = "https://discord.gg/NjajtTbMK", -- same thing here
        Icon = 1
})

local Tab = Window:CreateTab({
        Name = "Tab Example",
        Icon = "view_in_ar",
        ImageSource = "Material",
        ShowTitle = true
})

Luna:Notification({
        Title = "Notification",
        Icon = "notifications_active",
        ImageSource = "Material",
        Content = "Thanks for using my script", 

Tab:CreateSection("main")  

-- A. MEMBUAT DROPDOWN PILIHAN SENJATA DI LUNA UI
local WeaponDropdown = Tab:CreateDropdown({
    Name = "Pilih Senjata Farm",
    Description = nil,
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

Tab:CreateSection("ches farm")

local Toggle = Tab:CreateToggle({
	Name = "farm ches",
	Description = nil,
	CurrentValue = false,
    	Callback = function(Value)
       	 -- The function that takes place when the toggle is switched
       	 -- The variable (Value) is a boolean on whether the toggle is true or false
    	end
}, "Toggle") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps

Tab:CreateSection("bone")

local Toggle = Tab:CreateToggle({
	Name = "farm bone",
	Description = nil,
	CurrentValue = false,
    	Callback = function(Value)
       	 -- The function that takes place when the toggle is switched
       	 -- The variable (Value) is a boolean on whether the toggle is true or false
    	end
}, "Toggle") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps

local Tab = Window:CreateTab({
	Name = "auto get item",
	Icon = "robot",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})

Tab:CreateSection("CDK")
Tab:CreateDivider()

local Toggle = Tab:CreateToggle({
	Name = "auto tushita",
	Description = "get tushita",
	CurrentValue = false,
    	Callback = function(Value)
       	 -- The function that takes place when the toggle is switched
       	 -- The variable (Value) is a boolean on whether the toggle is true or false
    	end
}, "Toggle") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
