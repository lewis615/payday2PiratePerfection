--Purpose: shows version text in main menu

backuper:hijack('MenuNodeMainGui._setup_item_rows', function(o, self, ... )
	local r = o(self, ...)
	
	self._version_string:set_text( string.format("Pirate Perfection Reborn V%s\n Game version: %s", pp_config.const_version or '0', Application:version()))
	self._version_string:set_color(Color(0,0.7,0))
	self._version_string:set_alpha(0.85)
	return r
end)
