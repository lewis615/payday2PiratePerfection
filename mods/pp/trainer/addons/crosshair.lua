-- Crosshair

local hud_panel = Overlay:newgui():create_screen_workspace():panel()
local hit_confirm = hud_panel:bitmap( { valign="center", halign="center", visible = true, texture = "units/pd2_dlc1/weapons/wpn_effects_textures/wpn_sight_reticle_2_il", w = 50, h = 50, color = Color.white, layer = 0, blend_mode="add" } )
hit_confirm:set_center( hud_panel:w()/2, hud_panel:h()/2 )