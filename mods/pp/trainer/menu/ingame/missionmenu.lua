--Purpose: menu for scripts specific for several heists

if ( not GameSetup ) then
	return
end

local World = World
local W_spawn_unit = World.spawn_unit
local M_player = managers.player
local Idstring = Idstring
local pp_require = pp_require
pp_require('trainer/tools/new_menu/menu')
local is_server = is_server

local tr = Localization.translate

local path = "trainer/addons/missionmenu/"

local G_game_settings = Global.game_settings
local current_level = G_game_settings.level_id

local main

local Menu = Menu
local Menu_open = Menu.open

local spawn_plan = function()
	local player = M_player:player_unit()
    W_spawn_unit( World, Idstring("units/payday2/props/gen_prop_loot_confidential_folder_event/gen_prop_loot_confidential_folder_event"), player:position(), player:rotation() )
end

local overdrill = function()
	local scripts = managers.mission:scripts()
    for _, script in pairs( scripts ) do
		local elements = script:elements()
        for id, element in pairs( elements ) do
			local trigger_list = element:values().trigger_list or {}
            for _, trigger in pairs( trigger_list ) do
                if trigger.notify_unit_sequence == "light_on" then
                    element:on_executed()
                end
            end
        end
    end
end

-- Menu

local data = {
	{ text = tr.way_pointing, plugin = 'waypoints', switch_back = true },
	{ text = tr.debug_hud, plugin = 'debug_hud', switch_back = true },
	{ text = tr.intimidator, plugin = 'intimidator', switch_back = true },
	{ text = tr.shutdown_dialogs, plugin = "shutdown_dialogs", switch_back = true },
	{ text = tr.convert_all, callback = pp_require(path .. 'convert_all'), host_only = true },
	{ text = tr.tie_civs, callback = pp_require(path .. 'tie_civilians'), host_only = true },
	{ text = tr.reduce_ai_health, plugin = 'reduce_ai_health', switch_back = true, host_only = true },
	{ text = tr.increase_ai_amount, plugin = 'increase_ai_amount', switch_back = true, host_only = true },
}

if current_level == 'alex_1' or current_level == 'rat' then
	data[#data+1] = { text = tr.auto_cooker, plugin = 'autocooker', switch_back = true }
end

if current_level == "welcome_to_the_jungle_2" and is_server() then
	data[#data+1] = { text = tr.cengine_menu_title, callback = pp_dofile, data = path .. 'correctengine', menu = true, host_only = true }
end

if ( current_level == "arm_hcm" or current_level == "arm_cro" or current_level == "arm_fac" or current_level == "arm_par" or current_level == "arm_und" ) and is_server() then
	data[#data+1] = { text = tr.spawn_plan, callback = spawn_plan, host_only = true }
end

if current_level == "red2" and is_server() then
	data[#data+1] = { text = tr.overdrill, callback = overdrill, host_only = true }
end

data = { title = tr.mission_menu_title, button_list = data, plugin_path = path }
main = function()
	Menu_open( Menu, data )
end

return main