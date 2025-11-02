local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- color scheme
config.color_scheme = "Dracula"

-- fonts
config.font = wezterm.font_with_fallback({
  "FiraCode Nerd Font",
})
config.font_size = 14

-- tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 100

-- tabline.wez
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
    options = {
        -- theme = "catppuccin-mocha",
        theme = "Dracula",
        -- theme = "Cobalt Neon",
        section_separators = {
            left = wezterm.nerdfonts.ple_upper_left_triangle,
            right = wezterm.nerdfonts.ple_lower_right_triangle,
        },
        component_separators = {
            left = wezterm.nerdfonts.ple_forwardslash_separator,
            right = wezterm.nerdfonts.ple_forwardslash_separator,
        },
        tab_separators = {
            left = wezterm.nerdfonts.ple_upper_left_triangle,
            right = wezterm.nerdfonts.ple_lower_right_triangle,
        },
        -- color_overrides = {
        theme_overrides = {
            tab = {
                active = { fg = "#091833", bg = "#59c2c6" },
            },
        },
    },
    sections = {
        tab_active = {
            "index",
            { "process", padding = { left = 0, right = 1 } },
            "",
            { "cwd",     padding = { left = 1, right = 0 } },
            { "zoomed",  padding = 1 },
        },
        tab_inactive = {
            "index",
            { "process", padding = { left = 0, right = 1 } },
            "󰉋",
            { "cwd",     padding = { left = 1, right = 0 } },
            { "zoomed",  padding = 1 },
        },
    },
})

-- cursor
config.default_cursor_style = "SteadyBlock"
config.colors = {
    cursor_fg = "#11111b",
    cursor_bg = "#59c2c6",
    cursor_border = "#59c2c6",
}

-- opacity
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20

-- window size
config.initial_rows = 40
config.initial_cols = 140

-- prefixキーの設定（Ctrl + Space）
config.leader = {
    key = "Space",
    mods = "CTRL",
    timeout_milliseconds = 2000,
}

config.keys = {
    -- quick select (tmux-fingers)
    {
        mods = "LEADER",
        key = "F",
        action = wezterm.action.QuickSelect,
    },
    -- activate copy mode or vim mode
    {
        mods = "LEADER",
        key = "[",
        action = wezterm.action.ActivateCopyMode,
    },
      -- closing current tab
    {
        mods = "LEADER",
        key = "w",
        action = wezterm.action.CloseCurrentTab{ confirm = true },
    },
      -- closing current pane
    {
        mods = "LEADER",
        key = "x",
        action = wezterm.action.CloseCurrentPane{ confirm = true },
    },
      -- splitting
    {
        mods = "LEADER",
        key = "-",
        action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        mods = "LEADER",
        key = "|",
        action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
  -- pane move
    {
        mods = "LEADER",
        key = "l",
        action = wezterm.action.ActivatePaneDirection("Right"),
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
      -- pane zoom
    {
        mods = "LEADER",
        key = "z",
        action = wezterm.action.TogglePaneZoomState,
    },
    -- Create a new tab
    {
        mods = "LEADER",
        key = "c",
        action = wezterm.action.SpawnTab("DefaultDomain"),
    },
    -- Move to the next tab
    {
        mods = "LEADER",
        key = "n",
        action = wezterm.action.ActivateTabRelative(1),
    },
    -- Move to the previous tab
    {
        mods = "LEADER",
        key = "p",
        action = wezterm.action.ActivateTabRelative(-1),
    },
    -- Move to a specified tab ID
    {
        mods = "LEADER",
        key = "1",
        action = wezterm.action.ActivateTab(0),
    },
    {
        mods = "LEADER",
        key = "2",
        action = wezterm.action.ActivateTab(1),
    },
    {
        mods = "LEADER",
        key = "3",
        action = wezterm.action.ActivateTab(2),
    },
    {
        mods = "LEADER",
        key = "4",
        action = wezterm.action.ActivateTab(3),
    },
    {
        mods = "LEADER",
        key = "5",
        action = wezterm.action.ActivateTab(4),
    },
}

-- resize pane mode
table.insert(config.keys, {
    mods = "LEADER",
    key = "r",
    action = wezterm.action.ActivateKeyTable({
        name = "resize_pane",
        one_shot = false,
    }),
})

local act = wezterm.action
config.key_tables = {
    resize_pane = {
        { key = "LeftArrow",  action = act.AdjustPaneSize({ "Left", 1 }) },
        { key = "h",          action = act.AdjustPaneSize({ "Left", 1 }) },

        { key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
        { key = "l",          action = act.AdjustPaneSize({ "Right", 1 }) },

        { key = "UpArrow",    action = act.AdjustPaneSize({ "Up", 1 }) },
        { key = "k",          action = act.AdjustPaneSize({ "Up", 1 }) },

        { key = "DownArrow",  action = act.AdjustPaneSize({ "Down", 1 }) },
        { key = "j",          action = act.AdjustPaneSize({ "Down", 1 }) },

        -- Cancel the mode
        { key = "Escape",     action = "PopKeyTable" },
    },
}

return config
