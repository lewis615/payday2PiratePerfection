--Purpose: Teleport to the position of your crosshair. You can penetrate through walls If you'll enable it in the config.

if ( not GameSetup ) then
	return
end
local get_ray = get_ray
local pp_config = pp_config
local M_player = managers.player
local warp_to = M_player.warp_to
local rot0 = Rotation(0,0,0)

local function TELEPORT()
	local ray = get_ray( pp_config.TeleportPenetrate )
	if ray then
		warp_to(M_player, ray.hit_position, rot0)
	end
end

return TELEPORT