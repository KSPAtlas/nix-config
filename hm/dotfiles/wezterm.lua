-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Monokai (base16)'
config.font_size = 11.0
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = '5px',
  right = '5px',
  top = '5px',
  bottom = '5px'
}

config.term = "wezterm"

-- and finally, return the configuration to wezterm
return config
