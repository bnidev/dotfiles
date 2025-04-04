local wezterm = require("wezterm")
local config = {}
local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"
local act = wezterm.action

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.automatically_reload_config = true

-- config.color_scheme = 'Ef-Maris-Dark'
-- config.color_scheme = 'Tokyo Night'
-- config.color_scheme = 'Tokyo Night (Gogh)'
-- config.color_scheme = 'Tokyo Night Moon'
-- config.color_scheme = 'tokyonight'
-- config.color_scheme = 'Tokyo Night Storm'
config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = 'Catppuccin Macchiato'
config.font = wezterm.font("FiraCode Nerd Font")

-- config.window_decorations = 'RESIZE'
config.window_frame = {
	-- inactive_titlebar_bg = "none",
	-- active_titlebar_bg = "none",
}

config.colors = {
	tab_bar = {
		background = "#131c2b",
		active_tab = {
			bg_color = "#65d5a8",
			fg_color = "#131c2b",

			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
			-- label shown for this tab.
			-- The default is "Normal"
			intensity = "Normal",

			-- Specify whether you want "None", "Single" or "Double" underline for
			-- label shown for this tab.
			-- The default is "None"
			underline = "None",

			-- Specify whether you want the text to be italic (true) or not (false)
			-- for this tab.  The default is false.
			italic = false,

			-- Specify whether you want the text to be rendered with strikethrough (true)
			-- or not for this tab.  The default is false.
			strikethrough = false,
		},

		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = "#131c2b",
			fg_color = "#65d5a8",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab`.
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over inactive tabs
		inactive_tab_hover = {
			bg_color = "#1d2c39",
			fg_color = "#99bfcf",
			italic = false,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab_hover`.
		},

		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = "#131c2b",
			fg_color = "#65d5a8",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab`.
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over the new tab button
		new_tab_hover = {
			bg_color = "#1d2c39",
			fg_color = "#99bfcf",
			italic = false,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab_hover`.
		},
	},
}

config.window_close_confirmation = "NeverPrompt"

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
-- config.tab_and_split_indices_are_zero_based = false

config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
	{
		mods = "LEADER",
		key = "s",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "v",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		mods = "LEADER",
		key = "p",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		mods = "LEADER",
		key = "w",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		mods = "LEADER",
		key = "c",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "m",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		mods = "LEADER",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		mods = "LEADER",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		mods = "LEADER",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		mods = "LEADER",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "r",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "n",
		mods = "LEADER",
		action = act.ShowTabNavigator,
	},
	{
		key = "p",
		mods = "LEADER",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
}

for i = 0, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

-- tmux status
wezterm.on("update-right-status", function(window, _)
	local SOLID_LEFT_ARROW = ""
	local ARROW_FOREGROUND = { Foreground = { Color = "#bd1f30" } }
	local prefix = ""

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1F511) .. " " -- key emoji
		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	end

	if window:active_tab():tab_id() ~= 1 then
		ARROW_FOREGROUND = { Foreground = { Color = "#65d5a8" } }
	end -- arrow color based on if tab is first pane

	window:set_left_status(wezterm.format({
		{ Background = { Color = "#131c2b" } },
		{ Text = prefix },
		ARROW_FOREGROUND,
		{ Text = SOLID_LEFT_ARROW },
	}))
end)

if is_windows then
	config.default_prog = { "wsl.exe", "-d", "Ubuntu-24.04", "--cd", "~" }
	config.wsl_domains = {
		{
			name = "WSL:Ubuntu-24.04",
			distribution = "Ubuntu-24.04",
			default_cwd = "~",
		},
	}
end

return config
