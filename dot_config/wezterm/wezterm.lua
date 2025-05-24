local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("JetBrains Mono", { weight = "Regular", stretch = "Normal" })
config.font_size = 11.0
config.color_scheme = "Catppuccin Mocha"

config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config
