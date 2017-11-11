--Purpose: initiates autostart scripts here, depending on configuration.
--Note: Scripts here being executed both in game and in pre-game.

--Preloading values from table. You will face more of these preloads in other script files.
--This should increase speed of executing script at all trading off some RAM, because accessing locals & upvalues are much faster, than iterating and comparing with each hash from current table.
local pp_require = pp_require

local managers = managers
local Global = Global
local backuper = backuper
local backup = backuper.backup
local hijack = backuper.hijack
local os_clock = os.clock
local io_open = pp_io.open
local tab_insert = table.insert
local pp_dofile = pp_dofile
local pairs = pairs

local is_server = is_server()

local cfg = pp_config

if cfg.DisableAnticheat then
	pp_require 'trainer/addons/disable_anticheat'
end

if cfg.DLCUnlocker then
	pp_require 'trainer/addons/dlc_unlocker'
end

if cfg.EnableDebug then
	pp_require 'trainer/addons/debugenable'
end

if cfg.FreeAssets then
	backup(backuper, 'MoneyManager.get_mission_asset_cost_by_id')
	function MoneyManager.get_mission_asset_cost_by_id()return 0 end --Free assets
end

if cfg.FreePreplanning then
	pp_require 'trainer/addons/freepreplanning'
end

if cfg.HostMatters and is_server then
	pp_require 'trainer/addons/hostchooseplan'
end

if cfg.NoDropinPause then
	pp_require('trainer/addons/nopause')
end

if cfg.NoStatsSynced then
	--backuper:backup('NetworkAccountSTEAM.publish_statistics')
	function NetworkAccountSTEAM.publish_statistics()end
end

if cfg.check_for_updates then
	pp_require 'trainer/addons/updatechecker'
end

if cfg.AllPerks then
	pp_require 'trainer/addons/all_perks'
end

if cfg.DisableAutoKick then
	Global.game_settings.auto_kick = false
end

if cfg.AllSkins then
	pp_require 'trainer/addons/all_skins'
end

if cfg.announcements and MenuSetup then
	pp_require 'trainer/addons/announcements'
	local interval = cfg.announcements_interval or 180
	local t = Global.announce_T or (os_clock() - interval + 5)
	local M_announce_manager = managers.announce_manager
	local check_and_announce = M_announce_manager.check_and_announce
	RunNewLoopIdent('announce_loop',function()
			local _t = os_clock()
			if _t - t >= interval then
				t = _t
				Global.announce_T = _t
				check_and_announce(M_announce_manager)
			end
		end)
end

--Fist launch check
pp_require('trainer/menu/firstlaunch') 

--Notices users, if crash happened.
if cfg.ExceptionsCrashDetect and managers.exception then
	pp_require 'trainer/menu/crashnoticer'
end

if cfg.EnableJobFix then
	pp_require 'trainer/addons/jobfix'
end

if cfg.freed_hoxton then
	pp_require 'trainer/addons/unlock_hoxton'
end

if cfg.SpoofCards and not Global.game_settings.single_player then
	pp_require('trainer/addons/spoof_cards')
end

--Requires user scripts
pp_require 'trainer/custom_auto'