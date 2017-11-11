--Purpose: Tools for various
--Author: baldwin

pp_require 'trainer/tools/new_menu/menu'

local pp_dofile = pp_dofile
local managers = managers
local M_network = managers.network

local tr = Localization.translate

local Menu = Menu
local Menu_open = Menu.open

local main_menu

local force_start = function()
	M_network:session():spawn_players(true)
end

local path = "trainer/addons/tools/"

main_menu = function()
	local contents = {
		{ text = tr.unlock_all_preplaning, callback = pp_dofile, data = path .. 'allpreplaning'},
		{ text = tr.unlock_all_assets, callback = pp_dofile, data = path .. 'all_assets'},
		{ text = tr.force_game_start, callback = force_start, host_only = true },
		{ text = tr.want_that_title, callback = pp_dofile, data = path .. 'item_stealing_menu' },
	}
	
	Menu_open( Menu, { title = tr['tools_menu'], button_list = contents, plugin_path = path } )
end

return main_menu