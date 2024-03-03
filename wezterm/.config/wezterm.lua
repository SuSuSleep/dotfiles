-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Gruvbox Material (Gogh)"
config.default_domain = "WSL:Ubuntu-22.04"
config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "0cell",
	bottom = "0cell",
}

-- and finally, return the configuration to wezterm
return config
