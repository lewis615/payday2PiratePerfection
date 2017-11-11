--  Authors:  Configuration method by baldwin and ThisJazzman, menu by Davy Jones
--  Purpose:  Change base options in the game
local insert = table.insert
local pairs = pairs
local round = math.round
local len = string.len
local size = table.size
local sub = string.sub
local type = type
local unpack = unpack

local M_localization = managers.localization

local T_economy = tweak_data.economy

local ApplyConfigExtension = ApplyConfigExtension
local rlist_files = rlist_files

local tr = Localization.translate

local Menu = Menu
local Menu_open = Menu.open

local togg_vars = togg_vars
local pp_config = pp_config

local main_menu

local back_num = 0
local back_track = {}
local is_legacy

local prefix = "base_"

local options = {
	{name = "announce_sub", sub = {
		{name = "check_for_updates"},
		{name = "announcements"},
		{name = "announcements_interval", type = "slider", max = 720}
	}},
	{name = "HUD_sub", sub = {
		{name = "HUD"},
		{name = "HUD_VersionText"},
		{name = "HUD_MovingText"},
	}},
	{name = "general_sub", sub = {
		{name = "Language", menu = function() return rlist_files("trainer/translations/", "txt") or {} end},
		{name = "DLCUnlocker"},
		{name = "NoDropinPause"},
		{name = "FreeAssets"},
		{name = "FreePreplanning"},
		{name = "HostMatters", host = true},
		{name = "NoStatsSynced"},
		{name = "AllPerks"},
		{name = "freed_hoxton"},
		{name = "DisableAutoKick", host = true},
		{name = "Crosshair"},
		{name = "AllSkins"},
		{name = "ReduceDetectionLevel"},
	}},
	{name = "anticheat_sub", sub = {
		{name = "DisableAnticheat"},
		{name = "PreventEquipDetecting", host = true},
	}},
	{name = "equipment_sub", sub = {
		{name = "far_placements"},
		{name = "equipment_place_key", type = "input"},
	}},
	{name = "misc_sub", sub = {
		{name = "NoCivilianPenality"},
		{name = "NoInvisibleWalls", host = true},
		{name = "RestartProMissions", host = true},
		{name = "RestartJobs", host = true},
		{name = "NoEscapeTimer", host = true},
		{name = "ControlCheats", menu = {
			base_ControlCheats_false = false,
			base_ControlCheats_1 = 1,
			base_ControlCheats_2 = 2,
		}},
		{name = "LaserColor", color = true, disable = true},
		{name = "DontFreezeRagdolls"},
		{name = "DontDisposeRagdolls"},
		{name = "SecureAll"},
		{name = "NoSkinMods"},
	}},
	{name = "flying_sub", sub = {
		{name = "FreeFlightTeleport"},
		{name = "NoClipSpeed", type = "slider", max = 50},
	}},
	{name = "KillAll_sub", sub = {
		{name = "KillAllIgnoreTied"},
		{name = "KillAllIgnoreCivilians"},
		{name = "KillAllIgnoreEnemies"},
		{name = "KillAllTouchCameras"},
	}},
	{name = "character_sub", sub = {
		{name = "JumpHeightMultiplier", type = "slider", max = 100},
		{name = "RunSpeed", type = "slider", max = 500},
	}},
	{name = "job_sub", sub = {
		{name = "jobmenu_def_difficulty", menu = {
			"easy",
			"normal",
			"hard",
			"overkill",
			"overkill_145",
			"overkil_290",
		}},
		{name = "jobmenu_singleplayer"},
		{name = "EnableJobFix"},
	}},
	{name = "Spawn_sub", sub = {
		{name = "SpawnUnitsAmount", type = "slider", max = 100},
		{name = "SpawnPos", menu = {
			base_SpawnPos_ray = "ray",
			base_SpawnPos_spawn_point = "spawn_point",
			base_SpawnPos_random_spawn_point = "random_spawn_point",
		}},
		{name = "SpawnUnitKey", type = "input"},
	}},
	{name = "inventory_sub", sub = {
		{name = "rain_bags_amount", type = "slider", max = 1000},
		{name = "SpawnBagsAmount", type = "slider", max = 100},
		{name = "SpawnBagKey", type = "input"},
	}},
	{name = "slow_sub", sub = {
		{name = "SmSpeed", type = "slider", max = 100},
		{name = "SmSlowPlayer"},
	}},
	{name = "Xray_sub", sub = {
		{name = "XrayCams"},
		{name = "XrayCamsCol", color = true},
		{name = "XrayCiv"},
		{name = "XrayCivCol", color = true},
		{name = "XrayCops"},
		{name = "XrayCopsCol", color = true},
		{name = "XraySpecialCol", color = true},
		{name = "XraySniperCol", color = true},
		{name = "XrayFriendly", color = true},
		{name = "XrayItems"},
	}},
	{},
	{name = "TeleportPenetrate"},
	{name = "TrollAmountBags", type = "slider", max = 100},
	{},
	{name = "aimbot_sub", sub = {
		{name = "ShootThroughWalls"},
		{name = "MaxAimDist", type = "slider", max = 10000},
		{name = "AimbotInfAmmo"},
		{name = "AimbotDamageMul", type = "slider", max = 100},
		{name = "AimMode", menu = {
			base_AimMode_1 = 1,
			base_AimMode_2 = 2,
			base_AimMode_3 = 3,
		}},
		{name = "RightClick"},
	}},
	{name = "Lego_sub", sub = {
		{name = "LegoFile", type = "input"},
		{name = "LegoDeleteKey", type = "input"},
		{name = "LegoSpawnKey", type = "input"},
		{name = "LegoPrevKey", type = "input"},
		{name = "LegoNextKey", type = "input"},
	}},
	{name = "SpoofCards_sub", sub = function()
		local data = {{name = "SpoofCards"}, {}}
		for typ_n, typ in pairs({safes = T_economy.safes, drills = T_economy.drills}) do
			for id, item in pairs(typ) do
				insert(data, {name = typ_n..id, disp = M_localization:text(item.name_id)})
			end
			insert(data, {})
		end
		return data
	end},
	{},
	{name = "DebugDramaDraw"},
	{name = "DebugStateDraw"},
	{name = "DebugConsole"},
	{name = "DebugNavDraw"},
	{name = "DebugAdditionalEsp"},
	{name = "DebugMissionElements"},
	{name = "DebugElementsAdditional"},
	{},
	{name = "EnableDebug"},
	{name = "NameSpoof", type = "input"},
	{},
	{name = "LegacyMenu", forceout = true},
}

local function get_value(id)
	local pre_id = prefix..id
	return (togg_vars[pre_id] ~= nil and togg_vars[pre_id]) or (togg_vars[pre_id] == nil and pp_config[id])
end

local function config_edit(id, val, back)
	val = val == nil and not get_value(id) or val ~= nil and (val ~= "" and val or false)
	togg_vars[prefix..id] = val
	if back then
		main_menu()
	end
end

local create_item, create_sub, create_menu, create_color

create_item = function(opt)
	local name = opt.name
	if not name then
		return {}
	end
	local pre_name = prefix..name
	if togg_vars[pre_name] == nil then
		togg_vars[pre_name] = pp_config[name]
	end
	local opt_val = get_value(name)
	local is_color = opt.color
	local is_slider = opt.type == "slider"
	local is_input = opt.type == "input"
	local is_menu = opt.menu
	local is_sub = opt.sub
	local is_toggle = not is_sub and not is_menu and not is_color and not opt.type
	return {
		text = (opt.disp or is_legacy and not (is_sub or opt.notlegacy) and name or tr[pre_name])..(is_input and "  ( "..(opt_val or tr.base_none).." ) :" or "")..(opt.host and "    "..tr.host_only or ""),
		type = (is_toggle and "toggle") or opt.type or nil,
		toggle = (is_toggle and pre_name) or nil,
		slider_data = is_slider and {name = pre_name, value = opt_val, max = opt.max} or nil,
		callback = (is_toggle and config_edit) or (is_sub and create_sub) or (is_menu and create_menu) or (is_color and create_color) or nil,
		callback_input = (is_input and function(val) config_edit(name, val) end) or nil,
		data = (is_toggle and name) or (is_sub and {pre_name, opt}) or (is_menu and {name, opt}) or (is_color and {name, opt.disable}) or nil,
		switch_back = not opt.forceout and (is_toggle or is_slider or is_input) or nil,
		menu = is_sub or is_menu or is_color or nil,
	}
end

local function save_config()
	local pre_len = len(prefix)
	for id, val in pairs(togg_vars) do
		local check = sub(id, 1, pre_len)
		if check == prefix then
			id = sub(id, pre_len + 1)
			pp_config[id] = val
		end
	end
	pp_config()
	Menu_open(Menu, {title = tr[prefix.."menu"], description = tr.base_menu_restart, button_list = {}})
end

local save_button = {text = tr.save, type = "save_button", callback = save_config, name = prefix.."menu_save"}

create_sub = function(pre_id, menu)
	local opts = menu.sub
	if type(opts) == "function" then
		opts = opts()
	end
	local data = {}
	local i = 0
	local opts_size = size(opts)
	for _, opt in pairs(opts) do
		insert(data, create_item(opt))
		i = i + 1
		if i % 18 == 0 or i == opts_size then
			insert(data, {})
			insert(data, save_button)
		end
	end

	Menu_open(Menu, {title = tr[pre_id]..(menu.host and "    "..tr.host_only or ""), description = menu.desc and tr[pre_id.."_desc"] or nil, button_list = data, back = main_menu})
end

create_menu = function(id, menu)
	local opts = menu.menu
	if type(opts) == "function" then
		opts = opts()
	end
	local same_name = opts[1] and true
	local cur_val = get_value(id)
	local data = {}
	for ind, val in pairs(opts) do
		if cur_val == val then
			insert(data, 1, {})
			insert(data, 1, {text = tr.base_selected..":  "..(same_name and val or tr[ind]), switch_back = true})
		end
		insert(data, {text = same_name and val or tr[ind], callback = config_edit, data = {id, val, true}})
	end

	local pre_id = prefix..id
	Menu_open(Menu, {title = (is_legacy and not (menu.sub or menu.notlegacy) and id or tr[pre_id])..(menu.host and "    "..tr.host_only or ""), description = tr[pre_id.."_desc"], button_list = data, back = main_menu})
end

local c_tab = {"R", "G", "B"}

local function disable_color(id)
	for _, c in pairs(c_tab) do
		togg_vars[id..c] = false
	end
end

local b_c = "base_color"

create_color = function(id, disable)
	local data = {}
	for _, c in pairs(c_tab) do
		local id_c = id..c
		insert(data, {text = tr[b_c..c], type = "slider", slider_data = {name = prefix..id_c, value = get_value(id_c) or 1, max = 255}, switch_back = true})
	end
	local pre_id = prefix..id
	if disable then
		insert(data, {text = tr.base_disable, callback = disable_color, data = pre_id, switch_back = main_menu})
	end

	Menu_open(Menu, {title = tr[pre_id], description = tr[pre_id.."_desc"].."\n"..tr.base_color_ins, button_list = data, back = main_menu})
end

is_legacy = get_value("LegacyMenu")
togg_vars[prefix.."menu_save"] = true
local base_name = prefix.."menu"
main_menu = function() create_sub(base_name, {name = base_name, sub = options}) end
main_menu()