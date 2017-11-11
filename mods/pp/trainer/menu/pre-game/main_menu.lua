--Author: Simplity

local pp_require = pp_require
pp_require 'trainer/tools/new_menu/menu'

local pp_dofile = pp_dofile
local pairs = pairs
local ipairs = ipairs
local io_open = pp_io.open
local tab_insert = table.insert

local managers = managers

local Global = Global
local G_S_trees = Global.skilltree_manager.trees
local G_blackmarket = Global.blackmarket_manager

local tweak_data = tweak_data
local T_S_trees = tweak_data.skilltree.trees

local M_experience = managers.experience
local M_money = managers.money
local M_skilltree = managers.skilltree
local M_infamy = managers.infamy
local M_achievement = managers.achievment
local M_localization = managers.localization

local G_specs = Global.skilltree_manager.specializations

local tr = Localization.translate

local Menu = Menu
local Menu_open = Menu.open

local main_menu, other_menu, inventory_menu, infamy_menu, skill_menu, money_menu, level_menu, remove_items_menu

local path = "trainer/addons/main_menu/"

-- Functions

-- Level
local function change_level( level )
	M_experience:_set_current_level( level )
end

local function add_exp( value )
	M_experience:debug_add_points( value, false )
end

-- Money
local function add_money( value )
	M_money:_add_to_total(value)
end

local function reset_money()
	M_money:reset()
end

-- Skill points
local function set_skillpoints( value )
	M_skilltree:_set_points( value )
end

local function unlock_all_skills()
	set_skillpoints(580)
	
	local unlock_skill_tree = M_skilltree.unlock_tree
	local unlock_skill = M_skilltree.unlock
	for tree_id,tree_data in pairs( G_S_trees ) do
		unlock_skill_tree(M_skilltree, tree_id)
		
		for _,skills in pairs( T_S_trees[ tree_id ].tiers ) do
			for _,skill_id in ipairs( skills ) do
				unlock_skill(M_skilltree, tree_id, skill_id)
			end
		end
	end
end

local function set_perk_points( points )
	G_specs.total_points = points
	G_specs.points = points
end

local function reset_perks()
	M_skilltree:reset_specializations()
end

-- Infamy
local function set_infamy_level(level)
	M_experience:set_current_rank(level)
end

local function set_infamy_points(value)
	M_infamy:_set_points(value)
end

-- Inventory
local function unlock_slots()
	local unlocked_mask_slots = G_blackmarket.unlocked_mask_slots
	local unlocked_weapon_slots = G_blackmarket.unlocked_weapon_slots
	local unlocked_primaries = unlocked_weapon_slots.primaries
	local unlocked_secondaries = unlocked_weapon_slots.secondaries
	for i = 1, 300 do
		unlocked_mask_slots[i] = true 
		unlocked_primaries[i] = true
		unlocked_secondaries[i] = true
	end
end

local unlock_items = function( item_type )
	pp_require ( path .. 'unlock_items' )
	
	unlock_items( item_type )
end

local function delete_items()
	pp_require ( path .. 'clear_inventory' )
end

local clear_slots = function( category )
	pp_require ( path .. 'clear_slots' )
	
	clear_slots( category )
end

local remove_exclamation = function()
	Global.blackmarket_manager.new_drops = {}
end

-- Other
local function unlock_achievements()
	local _award = M_achievement.award
	for id in pairs(M_achievement.achievments) do
		_award(M_achievement, id)
	end
end

local function lock_achievements()
	M_achievement:clear_all_steam()
end

-- Menu

level_menu = function()	
	local data = { 
		{ text = tr['level_revolver'], plugin = "level_revolver" },
		{},
		{ text = tr['add_exp'] .. ":", type = "slider", slider_data = { name = "add_exp", value = 10000, max = 1000000 }, switch_back = true },
		{ text = tr['save'], type = "save_button", callback = add_exp, name = "add_exp" },
		{},
		{ text = tr['set_level'] .. ":", type = "slider", slider_data = { name = "set_level", value = 50, max = 255 }, switch_back = true },
		{ text = tr['save'], type = "save_button", callback = change_level, name = "set_level" },
	}
	
	Menu_open(Menu,  { title = tr['level_title'], button_list = data, plugin_path = path, back = main_menu } )
end

money_menu = function()
	local data = { 
		{ text = tr['reset_money'], callback = reset_money },
		{},
		{ text = tr['add_money_1'], callback = function() add_money(5000000000) end },
		{ text = tr['add_money_2'], callback = function() add_money(500000000) end },
		{ text = tr['add_money_3'], callback = function() add_money(50000000) end },
		{ text = tr['add_money_4'], callback = function() add_money(5000000) end },
	}
	
	Menu_open(Menu,  { title = tr['money_title'], button_list = data, back = main_menu } )
end

skill_menu = function()
	local data = {
		{ text = tr['unlock_all_skills'], callback = function() for i=1,2 do unlock_all_skills() end end },
		{ text = tr['unlock_tiers'], callback = pp_dofile, data = path .. "unlock_tiers" },
		{ text = tr['reset_points'], callback = set_skillpoints, data = 0 },
		{},
		{ text = tr['set_points'] .. ":", type = "slider", slider_data = { name = "skill_points", value = 120, max = 600 }, switch_back = true },
		{ text = tr['save'], type = "save_button", callback = set_skillpoints, name = "skill_points" },
		{},
		{ text = tr['set_perks'] .. ":", type = "slider", slider_data = { name = "perk_points", value = 2000, max = 110000 }, switch_back = true },
		{ text = tr['save'], type = "save_button", callback = set_perk_points, name = "perk_points" },
		--{ text = tr['reset_perk_points'], callback = function() G_specs.points = 0 end },
		{},
		{ text = tr['unlock_perks'], callback = function() pp_dofile(path..'unlock_all_specs') end },
		{ text = tr['lock_perks'], callback = reset_perks },
	}
	
	Menu_open(Menu,  { title = tr['skill_title'], button_list = data, back = main_menu } )
end

infamy_menu = function()
	local data = { 
		{ text = tr['reset_inf'], callback = function() set_infamy_level(0) end },
		{},
		{ text = tr['set_inf_points'] .. ':', type = "slider", slider_data = { name = "inf_points", value = 5, max = 25 }, switch_back = true },
		{ text = tr['save'], type = "save_button", callback = set_infamy_points, name = "inf_points" },
		{},
		{ text = tr['set_inf'] .. ':', type = "slider", slider_data = { name = "inf_level", value = 5, max = 25 }, switch_back = true },
		{ text = tr['save'], type = "save_button", callback = set_infamy_level, name = "inf_level" },
	}
		
	Menu_open(Menu,  { title = tr['inf_title'], button_list = data, back = main_menu } )
end

inventory_menu = function()
	local data = { 
		{ text = tr['clear_inventory_menu'], callback = remove_items_menu, menu = true },
		{ text = tr['remove_exclamation'], callback = remove_exclamation },
		{ text = tr['no_weap_mod_limit'], plugin = "no_weap_mod_limit", switch_back = true },
		{},
		{ text = tr['unlock_all_skins'], callback = pp_dofile, data = "trainer/addons/all_skins.lua" },
		{ text = tr['unlock_weapons'], callback = unlock_items, data = "weapons" },
		{ text = tr['unlock_weap_mods'], callback = unlock_items, data = "weapon_mods" },
		{ text = tr['unlock_masks'], callback = unlock_items, data = "masks" },
		{ text = tr['unlock_materials'], callback = unlock_items, data = "materials" },
		{ text = tr['unlock_textures'], callback = unlock_items, data = "textures" },
		{ text = tr['unlock_colors'], callback = unlock_items, data = "colors" },
		{},
		{ text = tr['unlock_all'], callback = unlock_items, data = "all" },
		{ text = tr['unlock_slots'], callback = unlock_slots },
		{},
		{ text = tr['safe_sim'], callback = pp_dofile, data = path.."safe_sim", menu = true}
	}
	
	Menu_open(Menu,  { title = tr['inv_title'], button_list = data, plugin_path = path, back = main_menu } )
end

remove_items_menu = function()
	local data = {
		{ text = tr['lock_all_items'], callback = delete_items },
		{ text = tr['clear_all_slots'], callback = clear_slots, data = "all" },
		{},
		{ text = tr['clear_secondaries_slots'], callback = clear_slots, data = "secondaries" },
		{ text = tr['clear_primaries_slots'], callback = clear_slots, data = "primaries" },
		{ text = tr['clear_masks_slots'], callback = clear_slots, data = "masks" },
	}
	
	Menu_open(Menu,  { title = tr['clear_inventory_menu'], button_list = data, back = inventory_menu } )
end

other_menu = function()
	local data = { 
		{ text = tr['lock_achievements'], callback = lock_achievements },
		{ text = tr['unlock_achievements'], callback = unlock_achievements },
	}
	
	Menu_open(Menu,  { title = tr['other_title'], button_list = data, back = main_menu } )
end

main_menu = function()
	local data = {
		{ text = tr['base_menu'], callback = pp_dofile, data = 'trainer/menu/pre-game/base_menu', menu = true },
		{ text = tr['level_title'], callback = level_menu, menu = true },
		{ text = tr['money_title'], callback = money_menu, menu = true },
		{ text = tr['skill_title'], callback = skill_menu, menu = true },
		{ text = tr['inf_title'], callback = infamy_menu, menu = true },
		{ text = tr['inv_title'], callback = inventory_menu, menu = true },
		{ text = tr['other_title'], callback = other_menu, menu = true },
		{ text = tr['inv_spec_menu'], callback = pp_dofile, data = 'trainer/menu/pre-game/allitemsmenu', menu = true },
	}
	
	Menu_open(Menu,  { title = tr['main_menu_title'], button_list = data } )
end

--TO DO: Reoptimise it wisely
return main_menu