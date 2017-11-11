--Unlocks all specializations.
--Author: ThisJazzman

local managers = managers
local M_skilltree = managers.skilltree
local tweak_data = tweak_data

local G_specs = Global.skilltree_manager.specializations
--local backup_points = G_specs.points
local spend_spec_points = M_skilltree.spend_specialization_points
local VAL = 13700 --For each tree

G_specs.total_points = 150700
G_specs.points = 150700

for spec,_ in pairs(G_specs) do
	if type(spec) == 'number' then
		spend_spec_points(M_skilltree, VAL, spec)
	end
end