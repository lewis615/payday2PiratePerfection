--Purpose: First launch greeting message.

local pp_require = pp_require
local backuper = backuper
local io_open = pp_io.open
local tr = Localization.translate

local main = function()
	pp_require 'trainer/tools/new_menu/menu'

	if io_open('firstlaunch.check','rb') then
		return
	end

	local data = {
		--{ text = tr.btn_close, is_cancel_button = true }
	}

	Menu:open({ title = tr.welcome_title, description = tr.welcome_message, button_list = data, w_mul = 2.5, h_mul = 3.2 })

	--menu:show()

	io_open('firstlaunch.check','w'):close()
end

backuper:add_clbk('MenuMainState.at_enter', main, 'first_time', 2)