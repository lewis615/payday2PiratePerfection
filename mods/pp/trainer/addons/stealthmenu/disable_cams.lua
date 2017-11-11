-- Disable cameras
-- Author: Simplity, Original: ?

local GroupAIStateBase = GroupAIStateBase
local pairs = pairs

plugins:new_plugin('disable_cams')

VERSION = '1.0'

local function toggle_cameras( state )
	for _,unit in pairs( GroupAIStateBase._security_cameras ) do
		unit:base():set_update_enabled( state )
	end
end

function MAIN()
	toggle_cameras( false )
end

function UNLOAD()
	toggle_cameras( true )
end

FINALIZE()