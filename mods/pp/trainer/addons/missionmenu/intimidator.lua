--Purpose: auto intimidator for enemies and civilians
--Author: baldwin

plugins:new_plugin('intimidator')

VERSION = '1.0'

local managers = managers
local GetPly = GetPlayerUnit
local M_enemy = managers.enemy
local HUGE = math.huge
local alive = alive
local pairs = pairs

local RunNewLoopIdent = RunNewLoopIdent
local StopLoopIdent = StopLoopIdent

--[[local backuper = backuper
local add_clbk = backuper.add_clbk
local remove_clbk = backuper.remove_clbk

local clbk = function( r, self )
	local ply = GetPly()
	if ( alive( ply ) )then
		local intimidate = self.on_intimidated
		if ( intimidate ) then
			intimidate( self, HUGE, ply )
		end
	end
end]]

function MAIN()
	--Managers should be static
	local function __clbk()
		local ply = GetPly()
		if not alive(ply) then
			return
		end
		for _,ud in pairs( M_enemy:all_civilians() ) do
			ud.unit:brain():on_intimidated(HUGE,ply)
		end
		for _,ud in pairs( M_enemy:all_enemies() ) do
			ud.unit:brain():on_intimidated(HUGE,ply)
		end
	end
	RunNewLoopIdent('intimidator', __clbk)
	--[[add_clbk(backuper, 'CopBrain.update', clbk, 'intimidator', 2)
	add_clbk(backuper, 'CivilianBrain.update', clbk, 'intimidator', 2)]]
end

function UNLOAD()
	--[[remove_clbk(backuper, 'CopBrain.update', 'intimidator', 2)
	remove_clbk(backuper, 'CivilianBrain.update', 'intimidator', 2)]]
	StopLoopIdent('initmidator')
end

FINALIZE()