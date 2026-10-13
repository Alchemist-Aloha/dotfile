-- Named scratchpad apps, implemented with the native Hyprland Lua API.
-- Referenced from config/binds.lua (launch-or-toggle binds) and
-- config/windowrules.lua (placement + guard rules).
-- API reference: /usr/share/hypr/stubs/hl.meta.lua

SCRATCHPADS = {
    -- {
    --     key    = "M",
    --     name   = "<Your music player>",
    --     class  = "<App class>",
    --     launch = "<Launch command>",
    --     size   = { "monitor_w*0.70", "monitor_h*0.75" },
    -- },
    {
        key    = "N",
        name   = "calculator",
        class  = "org.gnome.Calculator",
        launch = "uwsm app -- gnome-calculator",
        size   = { "monitor_w*0.30", "monitor_h*0.60" },
    },
    {
        key           = "Y",
        name          = "yazi",
        class         = "com.mitchellh.ghostty",
        initial_title = "^Yazi$",
        launch        = "uwsm app -- ghostty --title=Yazi -e yazi",
        tile          = true,
    },
    {
        key           = "B",
        name          = "btop",
        class         = "com.mitchellh.ghostty",
        initial_title = "^Btop$",
        launch        = "uwsm app -- ghostty --title=Btop -e btop",
        size          = { "monitor_w*0.30", "monitor_h*0.60" },
    },
    {
        key    = "T",
        name   = "thunderbird",
        class  = "org.mozilla.Thunderbird",
        launch = "uwsm app -- thunderbird",
        tile   = true,
    },
    {
        key    = "E",
        name   = "dolphin",
        class  = "org.kde.dolphin",
        launch = "uwsm app -- dolphin",
        tile   = true,
    },
}

-- Exact class strings above use plain string equality for Lua lookups;
-- window rules need a Hyprland regex, built here (dots escaped).
function scratchpad_rule_class(exact)
    return "^(" .. (exact:gsub("%.", "[.]")) .. ")$"
end

local function find_scratchpad_window(pad)
    for _, w in ipairs(hl.get_windows()) do
        local matched = w.class ~= nil and w.class == pad.class
        if matched and pad.initial_title then
            matched = w.initial_title ~= nil and w.initial_title:match(pad.initial_title) ~= nil
        end
        if matched then
            return w
        end
    end
    return nil
end

local function special_shown_on(mon, name)
    return mon ~= nil
        and mon.active_special_workspace ~= nil
        and mon.active_special_workspace.name == ("special:" .. name)
end

-- Returns a bind handler: launch the pad's app if absent, otherwise show/hide
-- its special workspace on the CURRENTLY FOCUSED monitor, so the pad opens
-- where the user is. Hyprland's toggle_special acts on the focused monitor:
-- it hides the special when shown there and otherwise shows/moves the display
-- (its windows follow) to the focused monitor. When showing, the pad's window
-- gets focused. The process keeps running while hidden.
function scratchpad_toggle(pad)
    return function()
        local w = find_scratchpad_window(pad)
        if not w then
            hl.exec_cmd(pad.launch)
            -- Give the window a moment to appear, then bring it to the user.
            local attempts = 0
            local t
            t = hl.timer(function()
                attempts = attempts + 1
                local nw = find_scratchpad_window(pad)
                if not nw and attempts <= 20 then
                    return
                end
                t:set_enabled(false)
                if not nw then
                    return
                end
                if not special_shown_on(hl.get_active_monitor(), pad.name) then
                    hl.dispatch(hl.dsp.workspace.toggle_special(pad.name))
                end
                hl.dispatch(hl.dsp.focus({ window = "address:" .. nw.address }))
            end, { timeout = 500, type = "repeat" })
            return
        end
        local selector = "address:" .. w.address
        local ws = w.workspace
        if ws and ws.special then
            local shown_here = special_shown_on(hl.get_active_monitor(), pad.name)
            hl.dispatch(hl.dsp.workspace.toggle_special(pad.name))
            if not shown_here then
                hl.dispatch(hl.dsp.focus({ window = selector }))
            end
        else
            local user_mon = hl.get_active_monitor()
            local shown_here = special_shown_on(user_mon, pad.name)
            hl.dispatch(hl.dsp.focus({ window = selector }))
            hl.dispatch(hl.dsp.window.move({ workspace = "special:" .. pad.name }))
            if user_mon ~= nil then
                hl.dispatch(hl.dsp.focus({ monitor = user_mon.name }))
            end
            if not shown_here then
                hl.dispatch(hl.dsp.workspace.toggle_special(pad.name))
            end
            hl.dispatch(hl.dsp.focus({ window = selector }))
        end
    end
end

-- Move the active window out of its special workspace (restore to normal).
function scratchpad_unscratch()
    local w = hl.get_active_window()
    if not w then return end
    local ws = w.workspace
    if not (ws and ws.special) then return end
    local mon = w.monitor or hl.get_active_monitor()
    local dest = mon and mon.active_workspace
    if dest then
        hl.dispatch(hl.dsp.window.move({ workspace = dest.name }))
    end
end
