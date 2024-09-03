local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config = {
  -- General
  automatically_reload_config = true,

  -- Window Settings
  window_close_confirmation = 'NeverPrompt',
  window_decorations = 'INTEGRATED_BUTTONS',

  window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
  },

  -- Theme & Font Settings
  -- color_scheme = 'Aci (Gogh)',
  -- color_scheme = 'MaterialOcean',
  -- color_scheme = 'Ef-Deuteranopia-Dark',
  color_scheme = 'Ef-Maris-Dark',
  font = wezterm.font 'FiraCode Nerd Font',

  -- Key Mappings
  keys = {
    {
      key = 'o',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
      ,
    }
  },

  -- define which WSL distribution to use (only needed for Windows)
  default_domain = "WSL:Ubuntu"
}

return config
