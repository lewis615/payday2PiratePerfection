--Purpose: script file that executes scripts, these are realyed on game_config

local pp_require = pp_require
local pp_dofile = pp_dofile
local type = type
local assert = assert
local rawget = rawget

local is_client = is_client()
local is_server = is_server()

local managers = managers
local M_blackmarket = managers.blackmarket

local in_game = in_game
local is_playing = is_playing

local backuper = backuper
local plugins = plugins

local query_execution_testfunc = query_execution_testfunc
local pp_config = pp_config
local DEFAULT_CONFIG="trainer/configs/default_config.lua"
local BLANK_CONFIG  ="trainer/configs/blank_config/blank.lua"

local config_path
do
	--Load game config
	local default_config = pp_config.DefaultConfig
	if ( type(default_config) == "string" ) then
		config_path = "trainer/configs/".. default_config..".lua"
		
		if ( not file_exists(config_path) ) then
			m_log_error('get_config_name() in auto_ingame.lua', "Config ".. default_config .." doesn't exists. Create it ?")
			config_path = DEFAULT_CONFIG
		end
	else
		m_log_error('get_config_name() in auto_ingame.lua', 'DefaultConfing is not string type. Check your config.lua and fix problems.')
		config_path = DEFAULT_CONFIG
	end
end

local cfg = pp_dofile(BLANK_CONFIG)
assert(cfg, "Trainer lacks of blank config. Was it moved to other place ?")
game_config = cfg
--Set path to itself for configuration saving
cfg.auto_config=config_path
--Apply extensions first, so __cloned config will be clear
ApplyConfigExtension(cfg, config_path)
do
	--Check for file containing config changes
	local modify_func=pp_dofile(config_path)
	if ( type(modify_func) == 'function' ) then
		modify_func(cfg)
	elseif ( modify_func ) then
		m_log_error("auto_config.lua", "Config structure changed, please remove old configuration files. Debug ( type(modify_func) ==", type(modify_func), ")")
	else
		m_log_error("auto_config.lua", "Trainer lacks of default configuration. Was it moved to other place ?")
	end
end

local path = "trainer/addons/"
local load_plugin = load_plugin( path )

local GetPlayerUnit = GetPlayerUnit

-- Character menu
if cfg.god_mode then
	query_execution_testfunc(GetPlayerUnit, { f = load_plugin, a = { 'charmenu/god_mode' } })
end

if cfg.no_fall_damage then
	load_plugin( 'charmenu/no_fall_damage' )
end

if cfg.high_jump then
	load_plugin( 'charmenu/high_jump' )
end

if cfg.kill_in_one_hit then
	load_plugin( 'charmenu/kill_in_one_hit' )
end

if cfg.increase_standard_speed then
	load_plugin( 'charmenu/increase_standard_speed' )
end

if cfg.no_hit then
	--query_execution_testfunc(is_playing, { f = load_plugin, a = { ( 'charmenu/no_hit' ) } })
	load_plugin( 'charmenu/no_hit' )
end

if cfg.shoot_through_walls then
	query_execution_testfunc(GetPlayerUnit, { f = load_plugin, a = { 'charmenu/shoot_through_walls' } })
end

if cfg.no_headbob then
	load_plugin( 'charmenu/no_headbob' )
end

if cfg.max_accurate then
	load_plugin( 'charmenu/max_accurate' )
end

if cfg.inf_ammo_reload then
	load_plugin( 'charmenu/inf_ammo_reload' )
end

if cfg.increase_speed then
	load_plugin( 'charmenu/increase_speed' )
end

if cfg.long_melee_range then
	load_plugin( 'charmenu/long_melee_range' )
end

if cfg.instant_melee then
	load_plugin( 'charmenu/instant_melee' )
end

if cfg.explosive_bullets then
	query_execution_testfunc(is_playing,{ f = load_plugin, a = { ( 'charmenu/explosive_bullets' ) } })
end

if cfg.infinite_ammo then
	load_plugin( 'charmenu/infinite_ammo' )
end

if cfg.no_recoil then
	load_plugin( 'charmenu/no_recoil' )
end

if cfg.extreme_firerate then
	load_plugin( 'charmenu/extreme_firerate' )
end

if cfg.hacked_maskoff then
	pp_require( path..'charmenu/hacked_maskoff' )
end

if cfg.no_flash_bangs then
	load_plugin( 'charmenu/no_flash_bangs' )
end

if cfg.infinite_stamina then
	load_plugin( 'charmenu/infinite_stamina' )
end

if cfg.no_bag_cooldown then
	load_plugin( 'charmenu/no_bag_cooldown' )
end

if cfg.increase_melee_dmg then 
	load_plugin( 'charmenu/increase_melee_dmg' )
end

if cfg.no_delay_melee then
	load_plugin( 'charmenu/no_delay_melee' )
end

-- Stealth menu

if cfg.inf_pager_answers and is_server then
	load_plugin( 'stealthmenu/inf_pager_answers' )
end

if cfg.inf_cable_activated then
	load_plugin( 'stealthmenu/inf_cable_activated' )
end

if cfg.cops_dont_shoot and is_server then
	load_plugin( 'stealthmenu/cops_dont_shoot' )
end

if cfg.prevent_panic_buttons and is_server then
	load_plugin( 'stealthmenu/prevent_panic_buttons' )
end

if cfg.inf_battery_activated and is_server then
	load_plugin( 'stealthmenu/inf_battery_activated' )
end

if cfg.disable_cams and is_server then
	query_execution_testfunc(is_playing,{ f = load_plugin, a = { ( 'stealthmenu/disable_cams' ) } })
end

if cfg.steal_pagers_on_melee then
	load_plugin( 'stealthmenu/steal_pagers_on_melee' )
end

if cfg.inf_converts then
	load_plugin( 'stealthmenu/inf_converts' )
end

if cfg.inf_follow_hostages then
	load_plugin( 'stealthmenu/inf_follow_hostages' )
end

if cfg.inf_body_bags then
	load_plugin( 'stealthmenu/inf_body_bags' )
end

if cfg.dont_call_police and is_server then
	load_plugin( 'stealthmenu/dont_call_police' )
end

if cfg.AnnoyerMode then
	load_plugin('nodelaytalk')
end

-- Interaction menu

if cfg.instant_interaction then
	load_plugin( 'interactions/interactionspeed' )
	BaseInteractionExt:toggle_int_speed(0.01)
elseif cfg.fast_interaction then
	load_plugin( 'interactions/interactionspeed' )
	BaseInteractionExt:toggle_int_speed(0.5)
end

if cfg.instant_intimidation and is_server then
	load_plugin( 'interactions/instant_intimidation' )
end

if cfg.ignore_walls then
	load_plugin( 'interactions/ignore_walls' )
end

if cfg.interact_with_all then
	load_plugin( 'interactions/interact_with_all' )
end

if cfg.infinite_distance then
	load_plugin( 'interactions/infinite_distance' )
end

if cfg.interact_and_look then 
	load_plugin( 'interactions/interact_and_look' )
end

-- Equipment menu

if cfg.invulnerable_sentry and is_server then
	load_plugin( 'equipment_menu/invulnerable_sentry' )
end

if cfg.sentry_infinite_ammo and is_server then
	load_plugin( 'equipment_menu/sentry_infinite_ammo' )
end

if cfg.drill_auto_service then
	load_plugin( 'equipment_menu/drill_auto_service' )
end

if cfg.instant_deployments then
	load_plugin( 'equipment_menu/instant_deployments' )
end

if cfg.non_consumable_equipments and is_server then
	load_plugin( 'equipment_menu/non_consumable_equipments' )
end

if cfg.inf_equipments then
	load_plugin( 'equipment_menu/inf_equipments' )
end

if cfg.instantdrills and is_server then
	load_plugin( 'equipment_menu/instantdrills' )
end

-- Inventory menu

if cfg.bag_throw_force then
	load_plugin( 'inventory_menu/bag_throw_force' )
end

if cfg.bag_no_penalty then
	load_plugin( 'inventory_menu/bag_no_penalty' )
end

if cfg.explosive_bags then
	load_plugin( 'inventory_menu/explosive_bags' )
end

-- Weapons list

if cfg.always_dismember then
	load_plugin( 'weapon_menu/always_dismember' )
end