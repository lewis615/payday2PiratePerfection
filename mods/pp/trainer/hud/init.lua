--HUD stuff here

--TO DO: Remake it from whitelist

pp_require('trainer/tools/workspace')

local pp_dofile = pp_dofile
local pp_config = pp_config
local ExGUIObject = ExGUIObject

local managers = managers
local M_gui = managers.gui_data

--Init object
--Confused about choose of workspace, seems 16_9 like a correct one since menu uses cutted workspace size
local pp_obj = ExGUIObject:new( GameSetup and M_gui:create_fullscreen_workspace() or M_gui:create_fullscreen_16_9_workspace() )

local G = getfenv(0)
G.pp_obj = pp_obj

pp_obj.__elements = {}

--pp_obj:setup_mouse() --Temporary debug

--Wrapped requires into separate function for update_object()
local function exec()
	--Version text
	if pp_config.HUD_VersionText and MenuSetup then
		pp_dofile('trainer/hud/version_text')
	end

	--Moving text
	if pp_config.HUD_MovingText then
		pp_dofile('trainer/hud/moving_text')
	end
end

--Called when resolution changed
function pp_obj:update_object()
	StopLoopIdent('moving_text')
	pp_obj:destroy()
	pp_obj = ExGUIObject:new( GameSetup and M_gui:create_fullscreen_workspace() or M_gui:create_fullscreen_16_9_workspace() )
	G.pp_obj = pp_obj
	pp_obj.__elements = {}
	--pp_obj:setup_mouse() --Temporary debug
	exec()
end

exec()