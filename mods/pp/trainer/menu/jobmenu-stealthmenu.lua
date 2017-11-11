-- Switch scripts between job menu and stealth menu

if ( GameSetup ) then
	return pp_dofile('trainer/menu/ingame/stealthmenu')
else
	return pp_dofile('trainer/menu/pre-game/jobmenu')
end