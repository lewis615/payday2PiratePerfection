local pp_require = pp_require
local setmetatable = setmetatable

pp_require 'trainer/tools/new_menu/menu'

local KeyInput = KeyInput
local tr = Localization.translate
local open_menu
do
	local Menu = Menu
	local open = Menu.open
	open_menu = function( ... )
		return open(Menu, ...)
	end
end
local Steam = Steam
local overlay_activate = Steam.overlay_activate

local main,credits

credits = function()
	local data = { { text = tr.back, callback = main }, { text = tr.btn_close } }
	open_menu({ title = tr.help_credits, description = tr.help_credits_desc, button_list = data, w_mul = 2.3, h_mul = 3.4 })
end

main = function()
	local fn = KeyInput.filenames
	setmetatable(fn, {__index = function() return tr['help_nokey'] end})
	local border = "------------------------------"
	local spacer = "    -    "
	open_menu(
		{
			title = tr.help_title,
			description = tr['help_bound']..":\n"..
				fn['main_menu-charmenu']..spacer..tr['main_menu_title'].." / "..tr['char_menu'].."\n"..
				fn['jobmenu-stealthmenu']..spacer..tr['job_menu_title'].." / "..tr['stealth_menu'].."\n"..
				fn['spawn_menu']..spacer..tr['spawn_menu'].."\n"..
				fn['troll_menu']..spacer..tr['troll_menu'].."\n"..
				fn['interactions']..spacer..tr['intm_title'].."\n"..
				fn['inventory_menu']..spacer..tr['inventory_menu'].."\n"..
				fn['weaponlistmenu']..spacer..tr['weapon_menu_title'].."\n"..
				fn['equipment_menu']..spacer..tr['equip_menu_title'].."\n"..
				fn['missionmenu']..spacer..tr['mission_menu_title'].."\n"..
				fn['tools']..spacer..tr['tools_menu'].."\n"..
				fn['music_menu']..spacer..tr['music_menu_title'].."\n"..
				border.."\n"..
				fn['help']..spacer..tr['help_title_t'].."\n"..
				fn['mod_menu']..spacer..tr['mod_menu'].."\n"..
				fn['carrystacker']..spacer..tr['help_carrystacker'].."\n"..
				fn['user_script']..spacer..tr['help_user_script'].."\n"..
				fn['config_menu']..spacer..tr['config_menu'].."\n"..
				fn['xray']..spacer..tr['base_Xray_sub'].."\n"..
				fn['replenish']..spacer..tr['help_replenish'].."\n"..
				fn['normalizer']..spacer..tr['Normalizer'].."\n"..
				fn['instant_win']..spacer..tr['help_instant_win'].."\n"..
				fn['teleport']..spacer..tr['help_teleport'].."\n"..
				fn['slowmotion']..spacer..tr['base_slow_sub'].."\n"..
				border.."\n"..
				fn['place_equipment']..spacer..tr['base_far_placements'],
			button_list = {
				{ text = tr.help_site, callback = overlay_activate, data = { Steam, "url",'https://pirateperfection.com' }},
				{ text = tr.help_credits, callback = credits }
			},
			w_mul = 2.3,
			h_mul = 3.4
		}
	)
end

return main