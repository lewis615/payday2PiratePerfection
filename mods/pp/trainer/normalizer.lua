--Purpose: restore modified by trainer functions

local tr = Localization.translate
local executewithdelay = executewithdelay
local plugins = plugins
local pp_dofile = pp_dofile
local pp_require = pp_require
local M_player = managers.player
local tweak_data = tweak_data
local restore_all_func
do
	local backuper = backuper
	local restore_all = backuper.restore_all
	restore_all_func = function( ... )
		return restore_all(backuper, ...)
	end
end

pp_require 'trainer/tools/new_menu/menu'
local open_menu
do
	local Menu = Menu
	local open = Menu.open
	open_menu = function( ... )
		return open(Menu, ...)
	end
end

local function restore()
	do
		--Toggle off xray, if it exists
		local xray_state = gXrayToggle
		if (xray_state) then
			local func, state = xray_state()
			if ( state ) then
				func()
			end
		end
	end
		
	if plugins then
		plugins:unload_except_by_cat("no_reload", true)
	end
	
	--[[local restore_hacked_upgrades = M_player.restore_hacked_upgrades
	if ( restore_hacked_upgrades ) then
		restore_hacked_upgrades(M_player)
	end]]
end

local function reboot()
	restore()
	pp_dofile('trainer/auto_config') --Thank you Simplity, your idea made it easier
	show_mid_text("Trainer successfully rebooted", "Pirate Perfection", 3)
end

local main

local menu_data = {
	{ text = tr.normalizer_restore, callback = restore },
	{ text = tr.normalizer_reboot, callback = reboot },
}
menu_data = { title = tr.Normalizer, description = tr.Normalizer_desc, button_list = menu_data, w_mul = 2.5, h_mul = 3.2 }

main = function()
	open_menu(menu_data)
end
return main