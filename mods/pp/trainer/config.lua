--Main Pirate Perfection config
--To turn on option here, after '=' write true, to turn off write false.
--Config frequently being updated through versions, don't forget to update it

return {
	--Pirate Perfection related options
	keyconfig = 'keyconfig', --Key bindings configuration filename. Use "keyconfig" (or false) to always load keyconfig.lua or "keyconfig_laptop.lua" for optimised for laptops default keys.
	check_for_updates = true, --This will check for new versions of Pirate Perfection and notify you, when it is available.
	announcements = true, --This will display announcements from Pirate Perfection about community events (including giveaways or group chat events)
	announcements_interval = 180, --Delay between game checks for new announcement
	HUD = true, --Set to false in order to disable ALL Pirate Perfection hud elements
	HUD_VersionText = true, --Displays current version of PP in main menu
	HUD_MovingText = true, --Displays moving text in main menu and in game.
	no_liberty_hook = true,

	--Logging
	LogErrorsToFile = true, --This will not only display PP related errors into console, but will write them into errlog.log

	--General options
	Language = 'english', -- Current language. Available languages: English, German, Portuguese, Turkish, Russian, Italian, Spanish, Schinese, Tchinese. Set to false to automatically choose language.
	--check_language_updates = false, --Set to true to automatically check and announce you, when any update for your language available
	DefaultConfig = 'default_config', -- Default config file, that is loaded automatically.
	DLCUnlocker = false, --Unlocks all dlcs in game. Use with caution, OVERKILL implemented check, if you wearing DLC item or creating DLC heist from DLC you don't own.
	NoDropinPause = false, --Disables drop-in pause, works both on client and host side.
	FreeAssets = true, --Purchase assets at no cost.
	FreePreplanning = true, --Free preplanning elements + no favors consumed for purchasing them.
	HostMatters = true, --Host forces plan he choosed in preplanning ignoring other players votes.
	ExceptionsEnabled = true, --Allows users to bypass some limit by warning (only equipment control stuff affected currently)
	ExceptionsCrashDetect = false, --Tries to detect whenever application was crashed or no. (Requires ExceptionsEnabled = true) Was planned to make process of locating latestcrash easier for cabin boys and it was success, but cabin boys experienced really weird problems with that.
	NoStatsSynced = true, --Prevents statistics being published to Steam. Disable this, if you're having problems with unlocking certain achievement, just make sure to set your profile from Public to other visibillity.
	DisableBindings = false, --Set to true in order to disable all binds (maybe usefull when you want to use only DLCUnlocker and some stealth cheats, like no recoil)
	AllPerks = false, --Gives you bonuses from all perks. Currently works odd and may cause crash, when you change armors.
	freed_hoxton = true, --Unlocks old hoxton without need to complete heist and being in official payday 2 group
	DisableAutoKick = true, --Turns off cheater auto kick option by default
	Crosshair = true, --Enable crosshair on all weapons
	AllSkins = true, --Gives you all skins
	ReduceDetectionLevel = false, --Reduces detection level.

	--Ingame autostart scripts.

	--Anticheat related
	DisableAnticheat = true, --Disables some anticheat checks, also it turns off DLC ownership checks.
	PreventEquipDetecting = false, --Experimental way to prevent extra grenades and equipments from tagging you as cheater. See stealth_cheating.lua for more info about method and negative effects aswell with its configuration.

	--Equipment placement settings
	far_placements = false, --Allows you to place equipments at any distance, ahywhere (Will cause visual glitch, where dummy equipment will not appear, when you place something)
	equipment_place_key = '4', --Key, to that will be binded placement of equipments from menu

	--Unsorted
	NoCivilianPenality = true, --No penalities for killing civilians
	NoInvisibleWalls = false, --Removes invisible walls (Host only)
	RestartProMissions = false, --Allow restart pro missions
	RestartJobs = false, --Returns "Restart" button, when you're hosting game
	NoEscapeTimer = false, --No escape timer (Host only)
	ControlCheats = false,
	--This option will limit placement of your equipments and grenade throws in order to prevent randomly being marked as cheater. Aswell it will prevent you from randomly changing your current weapon.
	--( false - always off, 1 - Turns on control, when you're client on someone's server, 2 - Always on).
	--More comming soon
	LaserColorR = false, --Change your weapon's laser color. Color format (as R.G.B.), 0, 128, 0 will be dark green. Set to false to disable this feature.
	LaserColorG = false,
	LaserColorB = false,
	DontFreezeRagdolls = false, --Never freezes corpses. May cause performance issues!
	DontDisposeRagdolls = false, --Corpses never disappear. May cause performance issues!
	SecureAll = false, --Secure any bag on any map.
	NoSkinMods = false, --Prevents skins from automatically adding their own modifications.

	-- Scripts settings
	FreeFlightTeleport = false, --Turning off freeflight will drop you at the position where freeflight camera was
	NoClipSpeed = 2,

	--Kill all script settings
	KillAllIgnoreTied = true, --Kill all script will ignore hostaged units.
	KillAllIgnoreCivilians = false, --Kill all script will ignore civilians
	KillAllIgnoreEnemies = false, --Kill all script will ignore enemies.
	KillAllTouchCameras = true, --Kill all scripts will kill all cameras aswell.

	--Character menu settings
	JumpHeightMultiplier = 5, --Multiplier for player's jump height. Set to false for default value (5).
	RunSpeed = 115, -- Maximum run speed. Set to false for default value (115).

	--Job menu settings
	jobmenu_def_difficulty = 'overkill_145', --Default difficulty choosed, when you host game from menu. Available difficulties ("easy","normal","hard","overkill","overkill_145","overkil_290")
	jobmenu_singleplayer = false, --Job menu will host singleplayer games by default (Can be toggled on/off in jobmenu manually)

	--Game fixes, debug stuff
	DisableBulletFix = false, --Disables fix on delayed bullet effect play.
	DisableInvFix = false, --Disables fix on ctd, when other player changes weapon.
	EnableJobFix = true, --Replaces job_class values to 10, so other players will see lobbies with jobs these game thinks "too hard for them". You also can see these jobs now when search.

	-- Spawn menu
	SpawnUnitsAmount = 1, --Amount of units being spawned, when you select some unit to spawn
	SpawnPos = 'ray', -- Spawn position ( "ray", "spawn_point", "random_spawn_point" )
	SpawnCivsAnim = 'cm_sp_stand_idle',  --Default animation set for civilians, when you spawn them
	SpawnEnemyAnim = 'idle', --Default animation set for enemies, when you spawn them
	SpawnUnitKey = "7", --Spawn unit button

	--Inventory menu settings
	rain_bags_amount = 100, --Default amount of rained bags
	SpawnBagsAmount = 1, --Default amount of spawned bags on single select.
	SpawnBagKey = "8", --Spawn bag button

	--Slowmotion
	SmSpeed = 20, -- Slow motion speed
	SmSlowPlayer = true, -- Affects slow motion on player

	--Xray
	--See LaserColor option for note about colors
	XrayCams = true, --Xray will highlight cameras
	XrayCamsColR = 255, --Camera's highlight color (Orange)
	XrayCamsColG = 51,
	XrayCamsColB = 0,
	XrayCiv = true, --Xray will highlight civilians
	XrayCivColR = 0, --Civilian's highlight color
	XrayCivColG = 0,
	XrayCivColB = 255,
	XrayCops = true, --Xray will highlight enemies
	XrayCopsColR = 255, --Cop's highlight color
	XrayCopsColG = 0,
	XrayCopsColB = 0,
	XraySpecialColR = 153, --Special's highlight color
	XraySpecialColG = 50,
	XraySpecialColB = 204,
	XraySniperColR = 0, --Sniper's highlight color (Green)
	XraySniperColG = 128,
	XraySniperColB = 0,
	XrayFriendlyR = 51, --Converted enemies color
	XrayFriendlyG = 204,
	XrayFriendlyB = 255,
	XrayItems = true, --Highlight some important to objective items (Highlights Framing Frame 3 objects and key cards)

	--Teleporter settings
	TeleportPenetrate = true, --Set to true if you want to penetrate through walls and props, when teleporting

	-- Troll menu
	TrollAmountBags = 5, --Amount of bags spawned on victims.

	-- AimBot
	ShootThroughWalls = false, --Allow AimBot shoot through walls.
	MaxAimDist = 5000, --AimBot max. detection range.
	AimbotInfAmmo = true, --Enable infinite ammo for AimBot.
	AimbotDamageMul = 2, --Damage multiplier, set to false to use default weapon damage.
	AimMode = 3, --AimBot mode (1 - Only auto shoot, 2 - Only aim, 3 - Auto aim and shoot).
	RightClick = false, --Only let the AimBot shoot if the right mouse button is held

	-- Lego
	LegoFile = 'default', --Default lego file.
	LegoDeleteKey = 'h', --Delete props button.
	LegoSpawnKey = '6', --Spawn props button.
	LegoPrevKey = '7', --Quick-switch to previous prop from the list
	LegoNextKey = '8', --Quick-switch to next prop from the list

	-- Loot Card Spoofer
	SpoofCards = false, --Fake your multiplayer loot drops to always drop a random safe or drill

	--Debug hud
	DebugDramaDraw = true, -- Enable drama hud.
	DebugStateDraw = true, -- Enable displaying state on unit.
	DebugConsole = true, -- Enable debug console.
	DebugNavDraw = false, -- Enable displaying debug navigation fields.
	DebugAdditionalEsp = true, -- Enable additional esp on units.
	DebugMissionElements = false, -- Enable drawing mission elements.
	DebugElementsAdditional	= false, -- Enable drawing additional mission elements.

	EnableDebug = false, --Enables debug menu, this also enables freeflight. (Menu got wiped by devs)
	NameSpoof = false, --Your new name in game, set to false in order to use your steam name. (OBSOLETE! NameSpoof is subject to remove)
	LegacyMenu = false, --Use config file names in PP Setup menu
} 
