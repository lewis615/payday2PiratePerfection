-- Infinite converts
-- Author: Idea: Transcend, Remade: PP Devs

plugins:new_plugin('inf_converts')

pp_require 'trainer/addons/plyupgradehack'

VERSION = '1.0'

function MAIN()
	local PlayerManager = PlayerManager
	local hack_upgrade_value = PlayerManager.hack_upgrade_value
	hack_upgrade_value(PlayerManager, 'player', 'convert_enemies_max_minions', 500)
	hack_upgrade_value(PlayerManager, 'player', 'convert_enemies_health_multiplier', 0.25)
end

function UNLOAD()
	local PlayerManager = PlayerManager
	local hack_upgrade_value = PlayerManager.hack_upgrade_value
	hack_upgrade_value(PlayerManager, 'player', 'convert_enemies_max_minions')
	hack_upgrade_value(PlayerManager, 'player', 'convert_enemies_health_multiplier')
end

FINALIZE()