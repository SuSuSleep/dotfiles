-- Pull in the wezterm API
local wezterm = require("wezterm")

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
config.font = wezterm.font 'FiraCode Nerd Font Mono'

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
config.keys = {
  {
    key = 'a',
    mods = 'CTRL',
    action = action.ActivateKeyTable {
      name = 'mux_pane',
      one_shot = falase,
    }
  },
}

config.key_tables = {
  mux_pane = {
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'h', action = action.ActivatePaneDirection 'Left' },
    { key = 'j', action = action.ActivatePaneDirection 'Down' },
    { key = 'k', action = action.ActivatePaneDirection 'Up' },
    { key = 'l', action = action.ActivatePaneDirection 'Right' },
    { key = 'H', action = action.AdjustPaneSize { 'Left', 5 } },
    { key = 'J', action = action.AdjustPaneSize { 'Down', 5 } },
    { key = 'K', action = action.AdjustPaneSize { 'Up', 5 } },
    { key = 'L', action = action.AdjustPaneSize { 'Right', 5 } },
    { key = '%', action = action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = '"', action = action.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'x', action = action.CloseCurrentPane { confirm = true } },
    { key = 'c', action = action.SpawnTab 'CurrentPaneDomain' },
    { key = '&', action = action.CloseCurrentTab { confirm = true } },
  }
}

for i = 1, 9 do
  table.insert( config.key_tables.mux_pane, {
    key = tostring(i),
    action = action.ActivateTab(i - 1),
  })
end

--- Top Right bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = false

local tab_bar_module = require 'tab_bar'
tab_bar_module.apply_format_title(wezterm)
tab_bar_module.apply_right_status(wezterm)

return config
