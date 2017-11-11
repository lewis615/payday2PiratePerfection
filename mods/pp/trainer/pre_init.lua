--[[
	Init file for some helpfull core functions.
	pp_require it before init.lua being executed.
]]

local pp_require = pp_require
local rawget = rawget
pp_require('trainer/tools/tools')

--Setup for underground light hook

local __require_after = rawget(_G, '__require_after')
if (__require_after) then
	local pp_dofile = pp_dofile
	local rawset = rawset
	local getmetatable = getmetatable
	local Application = Application
	
	__require_after['lib/entry'] = 
	function()
		--Inits trainer
		pp_dofile('trainer/init')
		--pp_dofile('trainer/freeflight')
	end

	__require_pre['core/lib/system/coresystem'] =
	function()
		--Enables freeflight
		rawset(getmetatable(Application),"debug_enabled",function() return true end)
	end
end
