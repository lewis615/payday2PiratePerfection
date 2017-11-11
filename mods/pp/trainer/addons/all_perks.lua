-- Enable all perks at once

for _, specialization in pairs( tweak_data.skilltree.specializations ) do
	for _, tree in pairs( specialization ) do
		if tree.upgrades then
			for _, upgrade in ipairs( tree.upgrades ) do
				managers.upgrades:aquire( upgrade,false )
			end
		end
	end
end