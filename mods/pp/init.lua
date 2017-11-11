local pp_dofile = pp_dofile
--Hack lines
if (not orig__dofile) then
	orig__dofile = pp_dofile
end
--End of hacks

pp_dofile('__require.lua') --Loading improved pp_require function
__first_require_clbk =
function()
	pp_dofile("trainer/pre_init")
	--Write here code that needs to be executed on very first pp_require.
end
--[[
--Callbacks, these executed before pp_require script being executed
__require_pre[required_script] = callback_function

--Callbacks, these executed after required script being executed
__require_after[required_script] = callback_function2

--Callbacks, these will override whole pp_require
__require_override[required_script] = callback_function3
]]

--Anything else, that needs to be executed on newstate goes here. Keep in mind, that only lua libs are opened at this stage, none of game internal classes, objects, methods are initialized yet.