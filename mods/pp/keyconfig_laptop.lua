--[[ Keys table:
	Keyboard: a-z (lowered!), 0-9, left shift, right shift, left ctrl, right ctrl, space, f1-14 num 0-9, num +, num -,  num . , num *, num enter, num lock, num /, home, insert, page up, page down
	Mouse: left_button, right_button, middle_button, x_button_1, x_button_2, x_button_3, x_button_4, x_button_5, wheel_up, wheel_down
	
	Possible table keys:
	ig_chat = true/false --If true, this will execute script and/or callback when you're typing something into chat, text input
	script = 'path_to_script' --Path to the script, that will be executed after key pressed
	handled_callback = 'path_to_script' --Path to the script, that pp_dofile will return callback function, that will be executed when binded key pressed
	callback = function() .. methods .. end/direct_function --Function, that will be executed after key pressed
	no_stuck = true/false --If true, key will no longer repeat itself by holding key down long enough
	
	Configuration entry examples:
	--If you want to execute script file on keypress
	['left shift'] = { script = 'trainer/autocooker.lua' },
	
	--If you want to execute function on keypress
	['z'] = { callback = function() managers.player:player_unit():base():replenish() end },
	
	--If you want to execute script, ignoring check if you're in chat and also never repeat script, if key holden.
	['x'] = { script = 'trainer/xray/xray.lua, ig_chat = true, no_stuck = true },
	
	** handled_callback note:
	--This way is recommended as it eliminates repeated and unnecessary script interpretation.
	--Though it have cons if you're developing some script, as it won't be reloaded anymore, unless you intepretate this script again
	
	--Comma after every entry is required, except if it is last entry in the table, where it isn't necessary.
]]

return {
	['x'] = { handled_callback = 'trainer/keybinded/xray.lua', no_stuck = true },
	['z'] = { handled_callback = 'trainer/keybinded/replenish.lua' },
	['5'] = { handled_callback = 'trainer/equipment_stuff/place_equipment.lua' },
	['f2'] = { handled_callback = 'trainer/menu/main_menu-charmenu.lua', no_stuck = true },
	['f3'] = { handled_callback = 'trainer/menu/jobmenu-stealthmenu.lua', no_stuck = true },
	['f4'] = { handled_callback = 'trainer/menu/ingame/spawn_menu.lua', no_stuck = true },
	['f5'] = { handled_callback = 'trainer/menu/ingame/troll_menu.lua', no_stuck = true },
	['f6'] = { handled_callback = 'trainer/menu/ingame/interactions.lua', no_stuck = true },
	['f7'] = { handled_callback = 'trainer/menu/ingame/inventory_menu.lua', no_stuck = true },
	['f8'] = { handled_callback = 'trainer/menu/ingame/weaponlistmenu.lua', no_stuck = true },
	['f10'] = { handled_callback = 'trainer/menu/ingame/equipment_menu.lua', no_stuck = true },
	['f11'] = { handled_callback = 'trainer/menu/ingame/missionmenu.lua', no_stuck = true },
	['insert'] = { handled_callback = 'trainer/normalizer.lua', no_stuck = true },
	['k'] = { handled_callback = 'trainer/menu/config_menu.lua', no_stuck = true },
	['-'] = { script = 'trainer/user_script.lua' },
	['`'] = { script = 'trainer/addons/carrystacker.lua' },
	['f1'] = { handled_callback = 'trainer/menu/help.lua', no_stuck = true },
	['delete'] = { handled_callback = 'trainer/menu/ingame/mod_menu.lua', no_stuck = true },
	['home'] = { handled_callback = 'trainer/menu/ingame/tools.lua', no_stuck = true },
	['x_button_1'] = { handled_callback = 'trainer/keybinded/slowmotion.lua' },
	['middle_button'] = { handled_callback = 'trainer/keybinded/teleport.lua' },
	['end'] = { handled_callback = 'trainer/keybinded/instant_win.lua', no_stuck = true },
	['+'] = { handled_callback = 'trainer/keybinded/music_menu.lua', no_stuck = true },
}