local wezterm = require("wezterm")
local config = wezterm.config_builder()


config.font = wezterm.font("JetBrains Mono", { weight = "Regular", stretch = "Normal" })
config.font_size = 11.0
config.color_scheme = "Catppuccin Mocha"

-- config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 1,
  right = 1,
  top = 1,
  bottom = 1,
}

if wezterm.target_triple:find("windows") then
  config.default_domain = "WSL:Ubuntu"
end
config.window_decorations = "RESIZE"

config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  {
    key = "s",
    mods = "LEADER|CTRL",
    action = wezterm.action.ActivateCommandPalette
  },
  {
    key = "d",
    mods = "LEADER|CTRL",
    action = wezterm.action.ShowDebugOverlay
  },
  {
    key = "c",
    mods = "LEADER",
    action = wezterm.action.ActivateCopyMode
  },
  {
    key = "f",
    mods = "LEADER",
    action = wezterm.action.Search({ CaseSensitiveString = "" })
  },
  {
    key = "f",
    mods = "LEADER|CTRL",
    action = wezterm.action.QuickSelect
  },
  {
    key = "e",
    mods = "LEADER",
    action = wezterm.action.PromptInputLine({
      description = "Enter new name for tab:",
      action = wezterm.action_callback(
        function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end
      )
    })
  },
  {
    key = "w",
    mods = "LEADER",
    action = wezterm.action.PromptInputLine({
      description = "Enter new name for workspace:",
      action = wezterm.action_callback(
        function(window, pane, line)
          if line then
            window:perform_action(
              wezterm.action.SwitchWorkspace({
                name = line,
              }),
              pane
            )
            window:active_tab():set_title(line)
          end
        end
      )
    })
  },
  {
    key = "w",
    mods = "LEADER|CTRL",
    action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" })
  },
  -- PANE CONTROLS
  {
    key = "v",
    mods = "LEADER",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" })
  },
  {
    key = "b",
    mods = "LEADER",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" })
  },
  {
    key = "x",
    mods = "LEADER",
    action = wezterm.action.CloseCurrentPane({ confirm = false })
  },
  {
    key = "z",
    mods = "LEADER",
    action = wezterm.action.TogglePaneZoomState
  },
  -- TAB CONTROLS
  {
    key = "t",
    mods = "LEADER",
    action = wezterm.action.SpawnTab("CurrentPaneDomain")
  },
  {
    key = "t",
    mods = "LEADER|CTRL",
    action = wezterm.action.CloseCurrentTab({ confirm = true })
  },
  {
    key = "1",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(0)
  },
  {
    key = "2",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(1)
  },
  {
    key = "3",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(2)
  },
  {
    key = "4",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(3)
  },
  {
    key = "5",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(4)
  },
  {
    key = "6",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(5)
  },
  {
    key = "7",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(6)
  },
  {
    key = "8",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(7)
  },
  {
    key = "9",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(-1)
  },
  -- FONT SIZE
  {
    key = "+",
    mods = "LEADER",
    action = wezterm.action.IncreaseFontSize
  },
  {
    key = "-",
    mods = "LEADER",
    action = wezterm.action.DecreaseFontSize
  },
  -- WINDOW CONTROLS
  {
    key = "n",
    mods = "LEADER",
    action = wezterm.action.SpawnWindow
  },
}

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
  direction_keys = { "h", "j", "k", "l" },
  modifiers = {
    move = "CTRL | SHIFT",
    resize = "ALT"
  }
})

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config, {
  position = "top"
})



return config
