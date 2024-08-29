local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config = {
  automatically_reload_config = true,
  -- enable_tab_bar = false,

  window_close_confirmation = 'NeverPrompt',
  window_decorations = 'RESIZE',

  -- window_frame = {
  --   border_left_width = '0.5cell',
  --   border_right_width = '0.5cell',
  --   border_bottom_height = '0.25cell',
  --   border_top_height = '0.25cell',
  -- },
  window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
  },
  -- Styling
  -- color_scheme = 'Aci (Gogh)',
  -- color_scheme = 'MaterialOcean',
  -- color_scheme = 'Ef-Deuteranopia-Dark',
  color_scheme = 'Ef-Maris-Dark',
  font = wezterm.font 'FiraCode Nerd Font',

  keys = {
    {
      key = 'o',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
      ,
    }
  },
  -- use WSL while on Windows
  default_domain = "WSL:Ubuntu"
}

return config
