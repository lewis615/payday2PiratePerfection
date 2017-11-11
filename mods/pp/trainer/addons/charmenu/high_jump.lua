-- High jump on run
-- Author: baldwin

plugins:new_plugin('high_jump')

local pp_config = pp_config

VERSION = '1.0'

CATEGORY = 'character'

function MAIN()
	backuper:hijack('PlayerStandard._start_action_jump', function( o, self, t, action_start_data, ... )
		if self._running then
			action_start_data.jump_vel_z = action_start_data.jump_vel_z * (pp_config.JumpHeightMultiplier or 5)
		end
		return o( self, t, action_start_data, ... )
	end)
end

function UNLOAD()
	backuper:restore('PlayerStandard._start_action_jump')
end

FINALIZE()