-- Switch scripts between main menu and char menu

if (GameSetup) then
	return pp_dofile('trainer/menu/ingame/charmenu')
else
	return pp_dofile('trainer/menu/pre-game/main_menu')
end