--Primary scripts, being used by PP.
--Purpose: initate commonly used scripts and requires
--Main Pirate Perfection configuration file

--Early init, so managers will be initiated succefully.
init()

local _G = _G

--Lobotomy init function, so it will not execute 2nd time
rawset( _G, 'init', function() end )

local assert = assert
local pp_require = pp_require
local type = type
local pp_dofile = pp_dofile
local ME_VERSION = '1.1.1'

local pp_config = pp_require('trainer/config')

assert(pp_config,'No config have been loaded!')
_G.pp_config = pp_config

local user_file = 'config.lua'
pp_config.auto_config = user_file

--Config extension method ApplyConfigExtension
--Used with pp_config and game_config
pp_require('trainer/tools/configmt')
--Apply extension
ApplyConfigExtension(pp_config, user_file)

do
	--Check if we can apply changes saved by user or automatically from game
	local modify_func = pp_dofile(user_file)
	if type(modify_func) == 'function' then
		modify_func(pp_config)
	end
end

pp_config.const_version = ME_VERSION

local Vector3 = Vector3
local Rotation = Rotation
local Network = Network
local World = World
local W_raycast = World.raycast
local Idstring = Idstring

local n_is_server = Network.is_server
local n_is_client = Network.is_client

local pairs = pairs
local unpack = unpack
local loadstring = loadstring
local io = io
local io_open = pp_io.open
local io_popen = pp_io.io_popen
local io_close = io.stdout.close
local string = string
local str_find = string.find
local str_split = string.split

local alive = alive
local managers = managers
local M_blackmarket = managers.blackmarket
local M_hud = managers.hud
local hud_present_mid_text
local hud_show_hint
if ( M_hud ) then
	hud_present_mid_text = M_hud.present_mid_text
	hud_show_hint = M_hud.show_hint
end
local M_chat = managers.chat
local chat_receive_message_by_name
local chat__receive_message
local chat_send_message
if ( M_chat ) then
	chat_receive_message_by_name = M_chat.receive_message_by_name
	chat__receive_message = M_chat._receive_message
	chat_send_message = M_chat.send_message
end
local M_network = managers.network
local M_localization = managers.localization
local M_trade = managers.trade
local trade_is_peer_in_custody
if ( M_trade ) then
	trade_is_peer_in_custody = M_trade.is_peer_in_custody
end
local M_player = managers.player
local M_slot = managers.slot
local get_mask = M_slot.get_mask
local tweak_data = tweak_data
local game_state_machine = game_state_machine
--game_state_machine:current_state_name
local game_current_state_name = game_state_machine.current_state_name

local m_log_error = m_log_error

local Global = Global

local Steam = Steam
local http_request = Steam.http_request

if ( not pp_config.no_liberty_hook ) then
	local f = io_open("IPHLPAPI.dll", "rb")
	assert( not f, "Please, remove IPHLPAPI.dll from game folder.")
end

--Fixes dumb behavior of _G
pp_require('trainer/tools/gfix')

 --[[
  Log scripts.
  
    m_log(...) --Logs to file and console
    m_log_v(...) --Logs to console only
    m_log_vs(...) --Logs to console only (on 1 line)
    m_log_a(mode, ...) --(Under rework)
    m_log_inspect(...) --Display table's contents into console
    m_log_full_inspect(...) --Display table's and other table's contents into console
    m_log_error(category, ...) --Displays warning in console and logs it into errlog, if user enabled to do so
	m_log_assert( obj [, msg]) --Displays message in console if obj is false or nil. Default message can be overriden using "msg" argument.
	safecall( func [, ...]) --Shortened xpcall, returns function's result or nil, if any error happened. Errors displayed into console with full traceback
	m_log_testfunc( function [, ...] ) --Tests how much it takes in order to execute single function. Results aren't 100% accurate. Function returns clocks/1000000.
]]
pp_require('trainer/tools/marylog')
--[[
  Backuper script for easy backing up and restoring functions.
  
    (Backuper) Backuper:new('backuper_name') --Initate new backuper for functions. Function returns new backuper.
    (function) Backuper:backuper('function_string') --Store new original function into backuper, once function is stored here, It cannot be overriden. As argument use function string. Function returns first function being stored here.
    Backuper:restore('function_string') --Restore original function, that was stored here.
    Backuper:restore_all() --Restores all original functions stored in backuper.
	(new_function) Backuper:hijack('function_string', new_function) --Backups function and then replace it by new_function. Just note, that new_function will always receive original function as 1st argument.
	(new_function) Backuper:hijack_adv('function_string', new_function) --Backups function and then replace it by special function, this will execute 1st new_function stored in backuper's hijacked table. new_function will receive array of hijacked functions( where 1st element is the original function) as 1st argument and 2nd argument reserved to help you implement ordinal system. 1st function executed receives number 1 as 2nd argument.
	Backuper:unhijack_adv('function_string', new_function) --Pops 1 of hijacked function from hijacked functions table. (new_function must be exact as it was stored in table) Function being restored, if hijacked functions table is empty.
	Backuper:add_clbk( 'function_string', new_function, id, pos ) --Adds callback function, this being executed before function being called (pos == 1) or after call (pos == 2). You can add multiple callbacks and all of them will be executed. id can be any, it will be used in order to remove callback
	Backuper:remove_clbk( 'function_string', [id, pos] ) --Performs operation, depending on id and pos arguments. If pos is nil, this will remove before and after callbacks by id. If id is nil, this will remove all callbacks, depending on pos. If both id and pos are nil, this will be equivalent to Backuper:restore()
]]
local backuper = pp_require('trainer/tools/origbackuper'):new("backuper")
_G.backuper = backuper
--[[ 
  Run new loop script. See pubinfloopv2.lua for more information.
]]
pp_require('trainer/tools/pubinfloopv2')

local RunNewLoop = RunNewLoop
local StopLoopIdent = StopLoopIdent
local executewithdelay = executewithdelay

--[[
	Experimental plugin manager
	See pluginmanager.lua and pluginbase.lua
]]
pp_require('trainer/experimental/dev/pluginmanager')
plugins = PluginManager:new()
local plugins = plugins
local plug_gloaded = plugins.g_loaded
local plug_unload = plugins.unload
local plug_require = plugins.pp_require
local required_plugins = plugins.required

--[[
	Localization script for PP menus and texts.
	Use Localization.translate[text_id] to get translation.
	Assign table above to local variable "tr" to follow our coding style.
	---------------------------------------------------------------------
	Localization:grab_list([ reply_clbk ]) --Gets lists of available translations. Calls reply_clbk with net_data table or false, depending on status.
	Localization:download_translation( id[,reply_clbk]) --Downloads translations and saves it into translations under name of (name).txt. Calls reply_clbk with language id and downloaded translation or false, depending on status.
]]
local localizator = pp_require('trainer/localizator')

local my_language = pp_config.Language or Steam:current_language()
local Localization = localizator:new(my_language) --Is steam language same as game language ? Confirm it please. @baldwin
_G.Localization = Localization
local tr = Localization.translate
--[[Still lazy to finish it :/
if (pp_config.check_language_updates) then
	local function reply( net_data )
		local data = net_data[my_language]
		if ( data ) then
			if ( data.v > tr.lan_ver ) then
				pp_require("trainer/tools/new_menu/menu")
				
			end
			return
		end
		m_log_error("{init.lua}","Failed to find language_id in net_data.")
	end
	Localization:grab_list( reply )
end
]]
--[[
	Helper module, that gives abillity to block game from destroying lua state, when some important threaded tasks are doing something.
	AddParallelTask( id ) --Adds id to task table
	EndedParallelTask( id ) --Removes id from task table
	RunParallelTask( func, id ) --Runs Lua function in separate thread. Usefull for heavy function, these stuns your game. Very unstable and tends to crash game in most of cases, + it maybe not supported by your hook.
]]	
local add_ptask
local end_ptask
do
	local parallelism = pp_require("trainer/tools/parallel_tasks")
	add_ptask = parallelism.AddParallelTask
	end_ptask = parallelism.EndedParallelTask
end

--[[Gives exception dialogs
	res structure:
	{ id = 'exception_id', clbk = ok_dialog_callback, c_clbk = cancel_dialog_callback, title = 'Exception title', text = 'Exception Description', ok = 'Ok button text', cancel = 'Cancel button text' }
	
	exception_manager:add( res ) --Adds resource to the exception (that will be lately catched by exception_manager.catch
	exception_manager:remove( id ) --Removes resorce of the exception by id
	(Disabled currently) exception_manager:add_trigger( function_string, res ) --Hooks function string. If exception triggers, then execution of the function will be prevented
	(Disabled currently) exception_manager:remove_trigger( function_string [, id] ) --Removes hook from the function. Also can remove exception by its id aswell.
	exception_manager:catch( id ) --Returns true if id is catched or else returns false
]]
if pp_config.ExceptionsEnabled then
	pp_require('trainer/menu/exceptions')
	local M_exception = exception_manager:new()
	local _add = M_exception.add
	
	if pp_config.ExceptionsCrashDetect then
		--Crashed game catch
		_add(M_exception, { id = 'crash_t',
				title = tr.except_crash_title,
				text = tr.except_crash_warn,
				ok = tr.except_yes,
				cancel = tr.except_no,
				clbk = function() os.execute('start latestcrash') end,
				no_except = true }
			)
	end
	
	managers.exception = M_exception
end

--Table for toggle variables
togg_vars = {}

local Color = Color
-- Colors
Color.purple = Color("9932CC")
Color.labia = Color("E75480")
Color.gold = Color("FFD700")
Color.silver = Color("CFCFC4")
Color.bronze = Color("CD7F32")
Color.neongreen = Color("39FF14")
Color.lilac = Color("D891EF")
Color.brown = Color("6B4423")
Color.grey = Color("B2BEB5")
Color.limited = Color("4F7942")
Color.unlimited = Color("FDEE00")
Color.pro = Color("7BB661")
Color.wip = Color("0D98BA")

load_plugin = function( path ) --Function, that constructs new load_plugin function (I hope you will get rid of this //baldwin)
	assert( plugins, 'Error! Plugin manger isn\'t loaded!' )
	return function( plugin, expensive )
		local real_name = required_plugins[path..plugin]
		if ( real_name and plug_gloaded( plugins, real_name ) ) then
			plug_unload( plugins, real_name --[[,true]] )
		else
			plug_require( plugins, path .. plugin, not expensive )
		end
	end
end

function GetNetSession()
	return M_network._session
end

local players_tab = M_player._players
function GetPlayerUnit()
	return players_tab[1]
end

--Like usuall Steam:http_request, but also retries request, if clbk isn't called
--"retry" param in seconds or nil, if you want regular http_request. Lower retry values may lead to other http_requests interupted for some reason!
--"id" param is anything, except booleans and nil. You can stop retries using id and StopLoopIdent( id )
function retry_http_request( url, clbk, retry, id )
	if ( retry and retry > 0 ) then
		local my_id
		local function success_clbk(...)
			StopLoopIdent( my_id )
			end_ptask( id or url )
			clbk(...)
		end
		local retry_func
		retry_func = function()
			http_request( Steam, url, success_clbk )
			my_id = executewithdelay( retry_func, retry, id )
		end
		retry_func()
		add_ptask( id or url )
		return my_id
	else
		http_request( Steam, url, clbk )
	end
end

function in_game() -- In game check
	return str_find(game_current_state_name(game_state_machine), "game")
end

function show_hint(msg) -- Show hint
	if ( hud_show_hint ) then
		hud_show_hint(M_hud, {text = msg})
	end
end

function show_mid_text( msg, msg_title, show_secs ) -- Show mid text
	if ( hud_present_mid_text ) then
		hud_present_mid_text( M_hud, { text = msg, title = msg_title, time = show_secs } )
	end
end

function chat_message(message, username) -- Send chat message
	chat_receive_message_by_name(M_chat, 1, username, message)
end

function in_chat() -- In chat and in overlay check
	if ( M_hud and M_hud._chat_focus ) then
		return true
	end
	local account = M_network.account
	if ( account and account._overlay_opened ) then
		return true
	end
	local TextInput = TextInput
	if ( TextInput and TextInput.active ) then
		return true
	end
end

local menu_system_message_loc = M_localization:to_upper_text( "menu_system_message" )
local sys_chat_col = tweak_data.system_chat_color
function system_message(message) -- Send system message
	chat__receive_message(M_chat, 1, menu_system_message_loc, message, sys_chat_col)
end

function send_message(message, username)
	chat_send_message(M_chat, 1, username, message)
end

local any_ingame_playing = BaseNetworkHandler._gamestate_filter.any_ingame_playing
local last_queued_state_name = game_state_machine.last_queued_state_name
function is_playing() -- Is playing check
	return any_ingame_playing[ last_queued_state_name(game_state_machine) ]
end

function is_server() -- Is server check
	return n_is_server(Network)
end

function is_client() -- Is client check
	return n_is_client(Network)
end

function in_custody( id ) -- Is in custody
	return trade_is_peer_in_custody( M_trade, id or M_network._session._local_peer._id )
end

local T_weapon = tweak_data.weapon

function in_table(table, value) -- Is element in table
	if type(table) == 'table' then
		for i,x in pairs(table) do
			if x == value then
				return true
			end
		end
	end
	return false
end

-- local s_freeflight = setup:freeflight()
local mvector3 = mvector3
local mvec_set = mvector3.set
local mvec_mul = mvector3.multiply
local mvec_add = mvector3.add
function get_ray(penetrate, slotMask) -- Get col ray
	if not slotMask then
		slotMask = "bullet_impact_targets"
	end
	local player = players_tab[1]
	if (alive(player)) then
		local camera = --[[s_freeflight._state == 0 and s_freeflight._camera_object or]] player:camera()
		local fromPos = camera:position()
		local mvecTo = Vector3()
		local forward = camera:rotation():y()
		mvec_set(mvecTo, forward)
		mvec_mul(mvecTo, 99999)
		mvec_add(mvecTo, fromPos)
		local colRay = W_raycast(World, "ray", fromPos, mvecTo, "slot_mask", get_mask(M_slot, slotMask))
		if colRay and penetrate then
			local offset = Vector3()
			mvec_set(offset, forward)
			mvec_mul(offset, 100)
			mvec_add(colRay.hit_position, offset)
		end
		return colRay
	end
end

local trip_slot = M_slot:get_mask("trip_mine_placeables")
function ray_pos() --Returns position and rotation of your crosshair.
	local unit = players_tab[1]
	if (alive(unit)) then
		local from
		local to
		local m_head_rot
		
		-- if s_freeflight._state == 0 then
			-- local camera = s_freeflight._camera_object
			-- m_head_rot = camera:rotation()
			-- from = camera:position()
			-- to = from + m_head_rot:y() * 99999
		-- else
			local ply_movement = unit:movement()
			m_head_rot = ply_movement:m_head_rot()
			from = ply_movement:m_head_pos()
			to = from + m_head_rot:y() * 99999 -- Idstring('?v=jkcGSwZ36pk') ???
		-- end

		local ray = W_raycast(World, "ray", from, to, "slot_mask", trip_slot, "ignore_unit", {})
		if (ray) then
			return ray.position, Rotation( m_head_rot:yaw(), 0, 0 )
		end
	end
end


function lua_run(path) -- Run lua file (unlike pp_dofile/dofiles/pp_require, it can return results of execution)
	local file = io_open(path, "r")
	if file then
		local exe = loadstring(file:read("*all"), path)
		file:close()
		if exe then
			return exe()
		else
			m_log_error("lua_run()","Error in '" .. path .. "'.\n")
		end
	else
		m_log_error("lua_run()","Couldn't open '" .. path .. "'.\n")
	end
end

--Recursively lists files in some dirrectory. Kinda slow, should be implemented at low level.
--Returns table, containing short filenames.
function rlist_files( path, ext )
	if not ext then ext = 'lua' end
	local list = io_popen("@echo OFF & cd "..path.." & for /r %f in (*."..ext..") do echo %~nf"):read("*all")
	
	if list ~= '' then
		return str_split(list, '\n')
	else
		m_log_error("rlist_files()", "Failed to retrive files in", path)
	end
end

--Checks if file located in "path" exists
function file_exists( path )
	local f=io_open(path, "r")
	if ( f ) then
		io_close(f)
		return true
	end
	return false
end
   
function is_hostage(unit) --Checks, if unit's hands tied or unit being intimidated to cuff himself.
	if alive(unit) then
		local brain = unit.brain
		brain = brain and brain( unit )
		if brain then
			local is_hostage = brain.is_hostage
			is_hostage = is_hostage and is_hostage( brain )
			if is_hostage then
				return true
			end
		end
		local anim_data = unit.anim_data
		anim_data = anim_data and anim_data(unit)
		if anim_data then
			local tied = anim_data.tied or anim_data.hands_tied
			if tied then
				return true
			end
		end
	end
	return false
end

local PackageManager = PackageManager
local all_loaded_unit_data = PackageManager.all_loaded_unit_data
function unit_on_map(unit_name) -- Checks, if unit loaded on map (give unit name)
	local id = Idstring(unit_name)
	for _,x in pairs( all_loaded_unit_data( PackageManager ) ) do
		if x:name() == id then
			return true
		end
	end
	return false
end

--Example: func_array = { f = some_function, a = { ...arguments... }, }
local function query_execution(func_array) --Works like script persisting but with functions.
	local f = func_array.f
	local params = func_array.a or {}
	local updator
	local stop = StopLoopIdent
	local function __clbk()
		f(unpack(params))
		stop(updator)
	end
	updator = RunNewLoop(__clbk)
end
_G.query_execution = query_execution

--Same as above, but will execute function only when testfunc returns true. Also if function is failed to execute, it will try again
function query_execution_testfunc(testfunc, func_array)
	local f = func_array.f
	local params = func_array.a or {}
	local updator
	local stop = StopLoopIdent
	local function __clbk()
		if testfunc() then
			f(unpack(params))
			stop(updator)
		end
	end
	updator = RunNewLoop(__clbk) --RunNewLoop secured with pcall, so you don't have to worry about crashy code.
end


local KeyInputCls = pp_require('trainer/experimental/kbinput')
local KeyInput
if ( KeyInputCls ) then
	KeyInput = KeyInputCls:new()
	_G.KeyInput = KeyInput
end
if (KeyInput) then
	if ( not pp_config.DisableBindings ) then
		KeyInput:run_updating( true )
		local keyboard_configuration,version = pp_dofile(pp_config.keyconfig or "keyconfig.lua")
		if ( keyboard_configuration ) then
			KeyInput.keys = keyboard_configuration
			KeyInput:help_setup()
		else
			m_log_error('{init.lua}', 'Failed to load keyconfig!')
		end
	end
else
	m_log_error('{init.lua}', 'Failed to init KeyInput!')
end

--Hud stuff
if pp_config.HUD then
	pp_require('trainer/hud/init')
end

--pp_require left scripts now.
pp_require('trainer/auto_init')

if GameSetup then --If GameSetup exsists, this means game being setted up.
	pp_require('trainer/auto_ingame')
end