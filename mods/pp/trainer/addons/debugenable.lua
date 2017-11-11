--Debug enabler by baldwin
--Purpose: enables debug menu

local GameSetup = GameSetup
if GameSetup then
	function GameSetup._update_debug_input() end -- Disable debug buttons
end

rawset(getmetatable(Application),"debug_enabled",function() return true end)