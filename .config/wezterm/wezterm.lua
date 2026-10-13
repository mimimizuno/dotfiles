-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This will hold the configuration.
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.font_size = 15.0
config.use_ime = true
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
}

config.window_background_gradient = {
    colors = { "#000000" },
}

config.show_new_tab_button_in_tab_bar = false

config.colors = {
    tab_bar = {
        inactive_tab_edge = "none",
    },
}

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local background = "#5c6d74"
    local foreground = "#FFFFFF"
    local edge_background = "none"

    if tab.is_active then
        background = "#ae8b2d"
        foreground = "#FFFFFF"
    end

    local edge_foreground = background
    local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

    return {
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_LEFT_ARROW },
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = title },
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_RIGHT_ARROW },
    }
end)

config.color_scheme = "AdventureTime"

-- Leader key
config.leader = {
    key = "a",
    mods = "CTRL",
    timeout_milliseconds = 1000,
}

config.keys = {
    -- 左右分割
    {
        key = "s",
        mods = "LEADER",
        action = wezterm.action.SplitHorizontal {
            domain = "CurrentPaneDomain",
        },
    },

    -- 上下分割
    {
        key = "v",
        mods = "LEADER",
        action = wezterm.action.SplitVertical {
            domain = "CurrentPaneDomain",
        },
    },

    -- ペイン移動
    {
        key = "h",
        mods = "LEADER",
        action = wezterm.action.ActivatePaneDirection "Left",
    },
    {
        key = "j",
        mods = "LEADER",
        action = wezterm.action.ActivatePaneDirection "Down",
    },
    {
        key = "k",
        mods = "LEADER",
        action = wezterm.action.ActivatePaneDirection "Up",
    },
    {
        key = "l",
        mods = "LEADER",
        action = wezterm.action.ActivatePaneDirection "Right",
    },

    -- 新しいタブ
    {
        key = "c",
        mods = "LEADER",
        action = wezterm.action.SpawnTab "CurrentPaneDomain",
    },

    -- タブの位置を入れ替え（左/右に1つ移動）
    {
        key = "H",
        mods = "LEADER|SHIFT",
        action = wezterm.action.MoveTabRelative(-1),
    },
    {
        key = "L",
        mods = "LEADER|SHIFT",
        action = wezterm.action.MoveTabRelative(1),
    },

    -- Copy Mode
    {
        key = "[",
        mods = "LEADER",
        action = wezterm.action.ActivateCopyMode,
    },

    -- ペインを閉じる
    {
        key = "x",
        mods = "LEADER",
        action = wezterm.action.CloseCurrentPane {
            confirm = true,
        },
    },
}

return config
