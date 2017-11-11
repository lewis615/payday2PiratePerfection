--Disable anticheat by baldwin, keeping up to date by Jazzman <http://pirateperfection.com/profile/17385-thisjazzman>
--Purpose: lobotomises several functions, responsible for checking for some cheats.

local PlayerManager = PlayerManager
local NetworkMember = NetworkMember
local NetworkPeer = NetworkPeer

function PlayerManager.verify_carry()return true end --Sometimes it blocks host from spawning bag, so it lobotomied
function PlayerManager.verify_equipment()return true end
function PlayerManager.verify_grenade()return true end
	
if NetworkMember then
	function NetworkMember.place_bag()return true end
end

local GrenadeBase = GrenadeBase
if ( GrenadeBase ) then
	function GrenadeBase.check_time_cheat()return true end --Removes grenade's launcher silly delay. Crazy firerate enabled again (though it will work only on host side)
end
if ( ProjectileBase ) then
	function ProjectileBase.check_time_cheat()return true end
end

--Here was create_ticket lobotomy, but it was removed due OVERKILL nerfed it
function NetworkPeer.begin_ticket_session()return true end
function NetworkPeer.on_verify_ticket()end
function NetworkPeer.end_ticket_session()end
function NetworkPeer.change_ticket_callback()end

function NetworkPeer.verify_job()end --Who cares own peer dlc heist or no
function NetworkPeer.verify_character()end --Doesn't forces people to pay for Female character
function NetworkPeer.verify_bag()return true end

function NetworkPeer.verify_outfit()end --Who cares own peer some outfit or no, saves a little of cpu aswell
function NetworkPeer._verify_outfit_data()end
function NetworkPeer._verify_cheated_outfit()end
function NetworkPeer._verify_content()return true end

function NetworkPeer.tradable_verify_outfit() end
function NetworkPeer.on_verify_tradable_outfit() end

-- Disable skills/perks/infamy check
pp_dofile "trainer/addons/disable_skills_check"
function InfamyManager._verify_loaded_data() end

-- Remove loot cap
tweak_data.money_manager.max_small_loot_value = math.huge
