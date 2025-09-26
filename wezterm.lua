-- vim:foldmethod=marker

local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
if string.find(wezterm.target_triple, "apple") then
  config.font_size = 11
else
  config.font_size = 10
end
config.color_scheme = 'GruvboxDark'
local bg_color = '#282828'

config.font = wezterm.font 'Liga Cousine'

--: Key bindings {{{
local act = wezterm.action
local NONE = act.DisableDefaultAssignment
config.keys = {
  { key = 'm', mods = 'SUPER', action = NONE },
  { key = '{', mods = 'SUPER|SHIFT', action = NONE },
  { key = '}', mods = 'SUPER|SHIFT', action = NONE },
  {
    key = '{',
    mods = 'CTRL|SHIFT',
    action = act.ActivateTabRelative(-1),
  },
  {
    key = '}',
    mods = 'CTRL|SHIFT',
    action = act.ActivateTabRelative(1),
  },
  {
    key = '"',
    mods = 'CTRL|SHIFT',
    action = act.SplitVertical{domain="CurrentPaneDomain"},
  },
  {
    key = '%',
    mods = 'CTRL|SHIFT',
    action = act.SplitHorizontal{domain="CurrentPaneDomain"},
  },
  {
    key = 'Enter',
    mods = 'CTRL|SHIFT',
    action = act.ShowLauncher,
  },
  {
    key = 'F11',
    mods = 'CTRL|SHIFT',
    action = act.ToggleFullScreen,
  },
}
--: }}}

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config, {
  position = 'top'
})

config.window_frame = {
  border_top_height   = '0.5cell',
  border_top_color    = bg_color,
  border_bottom_color = bg_color,
  border_left_color   = bg_color,
  border_right_color  = bg_color,
}

-- Finally, return the configuration to wezterm:
return config
