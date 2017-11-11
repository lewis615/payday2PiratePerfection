-- God mode for sentry gun
-- Author: baldwin

plugins:new_plugin('invulnerable_sentry')

VERSION = '1.0'

function MAIN()
	backuper:backup('SentryGunDamage.damage_bullet')
	function SentryGunDamage.damage_bullet()end
end

function UNLOAD()
	backuper:restore('SentryGunDamage.damage_bullet')
end

FINALIZE()