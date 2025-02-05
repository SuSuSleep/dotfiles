-- Pull in the wezterm API
local wezterm = require("wezterm")

-- maximum window when start
local mux = wezterm.mux
wezterm.on("gui-startup", function()
	local _, _, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

-- Define wezterm action
local action = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- Font
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 13.5
config.line_height = 1.1

-- Changing the color scheme:
config.color_scheme = "Catppuccin Mocha"
config.window_padding = {
	left = "0cell",
	right = "0cell",
	top = "0cell",
	bottom = "0cell",
}

-- Disable audio
config.audible_bell = "Disabled"

-- Mux
config.inactive_pane_hsb = {
	saturation = 0.6,
	brightness = 0.5,
}
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1500 }
config.keys = {
	{ key = "h", mods = "LEADER", action = action.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = action.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = action.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = action.ActivatePaneDirection("Right") },
	{ key = "H", mods = "LEADER", action = action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "J", mods = "LEADER", action = action.AdjustPaneSize({ "Down", 5 }) },
	{ key = "K", mods = "LEADER", action = action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "L", mods = "LEADER", action = action.AdjustPaneSize({ "Right", 5 }) },
	{ key = "%", mods = "LEADER", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = '"', mods = "LEADER", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "x", mods = "LEADER", action = action.CloseCurrentPane({ confirm = true }) },
	{ key = "c", mods = "LEADER", action = action.SpawnTab("CurrentPaneDomain") },
	{ key = "&", mods = "LEADER", action = action.CloseCurrentTab({ confirm = true }) },
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = action.ActivateTab(i - 1),
	})
end

--- Top Right bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = false

local tab_bar_module = require("tab_bar")
tab_bar_module.apply_format_title(wezterm)
tab_bar_module.apply_right_status(wezterm)

--- domain
config.ssh_domains = {
	{
		name = "lab08",
		remote_address = "192.168.50.58",
		username = "johnson",
	},
}
return config
