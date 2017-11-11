--Purpose: initiates autostart in game scripts here, depending on configuration.

local pp_require = pp_require
local pp_dofile = pp_dofile

local is_client = is_client()
local is_server = is_server()

local managers = managers
local M_player = managers.player
local M_blackmarket = managers.blackmarket

local in_game = in_game
local is_playing = is_playing

local backuper = backuper
local backup = backuper.backup
local plugins = plugins
local plug_require = plugins.pp_require

local query_execution_testfunc = query_execution_testfunc

local path = "trainer/addons/"
local load_plugin = load_plugin( path )

local cfg = pp_config

pp_require("trainer/addons/weap_fix1")

pp_dofile('trainer/auto_config')

--pp_require depending on pp_config scripts

if not cfg.DisableBulletFix then
	pp_require('trainer/addons/bulletfix')
end

local ControlLevel = cfg.ControlCheats
if ControlLevel and ((is_client and ControlLevel == 1) or ControlLevel >= 2) then --Autostart equipment control
	plug_require(plugins, 'trainer/equipment_stuff/equipment_control', true)
end

if cfg.NoInvisibleWalls and is_server then -- No invisible walls (Host only)
	query_execution_testfunc(is_playing,{ f = function() pp_dofile 'trainer/addons/no_invisible_walls.lua' end })
end

if cfg.RestartProMissions and is_server then -- Restart pro missions (it also includes RestartJobs)
	pp_require('trainer/addons/restart_pro_missions.lua')
end

if cfg.RestartJobs and is_server then
	pp_require('trainer/addons/restart_jobs')
end

if cfg.NoEscapeTimer and is_server then -- No escape timer (Host only) (By Harfatus)
	backup(backuper, 'ElementPointOfNoReturn.on_executed')
	function ElementPointOfNoReturn.on_executed() end
end

if cfg.NoCivilianPenality then
	pp_require('trainer/addons/freecivilians')
end

if cfg.DontFreezeRagdolls then
	backup(backuper, 'CopActionHurt._freeze_ragdoll')
	function CopActionHurt._freeze_ragdoll()end
end

if cfg.DontDisposeRagdolls then
	backup(backuper, 'EnemyManager._upd_corpse_disposal')
	function EnemyManager._upd_corpse_disposal()end
end

if cfg.LaserColorR then
	pp_require('trainer/weapon_stuff/lasercolor')
end

if not cfg.DisableInvFix then
	pp_require('trainer/addons/invfix')
end

if cfg.far_placements then
	plug_require(plugins, 'trainer/equipment_stuff/long_placement', true)
end

if is_server and cfg.SecureAll then
	pp_require('trainer/addons/secureall')
end

if cfg.HUD then
	pp_require("trainer/addons/pp_text")
end

if cfg.Crosshair then
	pp_require("trainer/addons/crosshair")
end

--Requires user scripts

pp_require('trainer/custom_game')