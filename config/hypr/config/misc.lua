hl.config({
    general = {
        layout = "scrolling",
    },
    scrolling = {
        column_width = 0.67,
        explicit_column_widths = "0.333, 0.5, 0.667, 1.0",
        focus_fit_method = 1,
        follow_min_visible = 0.25,
    },
    dwindle = {
        preserve_split = true,
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
    misc = {
        col = {
            splash = CACHYLGREEN,
        },
        middle_click_paste = false,
        enable_swallow = true,
        swallow_regex = "(kitty|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)",
        vrr = 3,
    },
    render = {
        direct_scanout = 2,
    },
    xwayland = {
        force_zero_scaling = true
    },
})