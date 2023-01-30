local wezterm = require "wezterm"

local my_colors = {
    a = { fg = "#24283b", bg = "#7aa2f7" },
    b = { fg = "#7aa2f7", bg = "#3b4261" },
    c = { fg = "#828bb8", bg = "#1e2030" }
}

local separators = {
    main = { left = '', right = '' },
    sub = { left = '', right = '' },
}

wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
        local tab_title = {
            st = " " .. tab.active_pane.title .. " ",
            bg = my_colors.b.bg,
            fg = my_colors.b.fg,
        }
        local separator = {
            st = separators.sub.left,
            bg = my_colors.b.bg,
            fg = my_colors.b.fg,
        }
        if tab.is_active then
            tab_title.bg = my_colors.a.bg
            tab_title.fg = my_colors.a.fg
            separator.st = separators.main.left
            separator.fg = my_colors.a.bg
            if tab.tab_index + 1 == #tabs then
                separator.bg = my_colors.c.bg
            else
                separator.bg = my_colors.b.bg
            end
        else
            if tab.tab_index + 1 == #tabs then
                separator.st = separators.main.left
                separator.fg = my_colors.b.bg
                separator.bg = my_colors.c.bg
            elseif tabs[tab.tab_index + 2].is_active then
                separator.st = separators.main.left
                separator.fg = my_colors.b.bg
                separator.bg = my_colors.a.bg
            end
        end
        return {
            { Background = { Color = tab_title.bg } },
            { Foreground = { Color = tab_title.fg } },
            { Text = tab_title.st },
            { Background = { Color = separator.bg } },
            { Foreground = { Color = separator.fg } },
            { Text = separator.st }
        }
    end
)

wezterm.on(
    'update-right-status',
    function(window, pane)
        local date_format = " %I:%M %p " .. separators.sub.right .. " %A " .. separators.sub.right .. " %B %-d "
        local date = wezterm.strftime(date_format)
        local bat = " "
        for _, b in ipairs(wezterm.battery_info()) do
            if b.state == "Charging" then
                bat = bat .. ""
            elseif b.state == "Unknown" then
                bat = bat .. ""
            elseif b.state_of_charge <= 0.2 then
                bat = bat .. ""
            else
                bat = bat .. ""
            end
            bat = bat .. string.format('%.0f%%', b.state_of_charge * 100) .. " "
        end
        window:set_right_status(
            wezterm.format {
                { Foreground = { Color = my_colors.b.bg } },
                { Background = { Color = my_colors.c.bg } },
                { Text = separators.main.right },
                { Foreground = { Color = my_colors.b.fg } },
                { Background = { Color = my_colors.b.bg } },
                { Text = bat },
                { Foreground = { Color = my_colors.a.bg } },
                { Background = { Color = my_colors.b.bg } },
                { Text = separators.main.right },
                { Foreground = { Color = my_colors.a.fg } },
                { Background = { Color = my_colors.a.bg } },
                { Text = date },
            }
        )
    end
)

return {
    colors = {
        tab_bar = {
            background = my_colors.c.bg,
            active_tab = {
                bg_color = my_colors.a.bg,
                fg_color = my_colors.a.fg
            },
            inactive_tab = {
                bg_color = my_colors.c.bg,
                fg_color = my_colors.c.fg
            },
            new_tab = {
                bg_color = my_colors.c.bg,
                fg_color = my_colors.c.fg
            }
        }
    },
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,
    tab_max_width = 100,
    font_size = 11.0,
    font = wezterm.font_with_fallback {
        "JetBrains Mono",
        "HackGenNerd Console"
    },
    use_ime = true,
    color_scheme = "tokyonight-storm",
    initial_cols = 140,
    initial_rows = 39,
    window_padding = {
        right = 0,
        left = 0,
        top = 0,
        bottom = 0,
    },
}
