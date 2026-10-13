# Linux dotfiles for Hyprland+Noctalia+Fish

This setup is built around three parts: Hyprland manages scrolling windows and keyboard shortcuts, Noctalia supplies the desktop shell and panels, and Fish is the interactive shell. The Hyprland config is written in Lua and assumes UWSM for launching applications.

Hyprland has no ordinary minimize/hide action for a window, so these configs use named special workspaces as scratchpads. A shortcut launches an app the first time, then shows or hides its special workspace on later presses. Hiding leaves the app running; it does not close the window or its process. The scratchpad rules cover Dolphin, Thunderbird, Yazi, btop, and GNOME Calculator.

This repository is a sanitized set of my configuration files for a Hyprland workstation. It is a starting point for another machine, not a drop-in installer: back up your current settings and adjust monitor names, display modes, application commands, and paths before copying files into `~/.config` or your home directory. Some settings use generic placeholders such as `$HOME`, `USERNAME`, or `GITHUB_OWNER`; replace them with values that make sense on your system.

## Default applications

Hyprland's defaults in `config/hypr/config/variables.lua` are:

| Role | Default |
| --- | --- |
| Terminal | Ghostty |
| File manager | Dolphin |
| Browser | Google Chrome Stable |
| GUI editor | GNOME Text Editor |
| Calculator | GNOME Calculator |

Fish separately sets `EDITOR=fresh`, so terminal tools that honor `$EDITOR` use Fresh.

## Configuration included

This repository currently includes configuration for Hyprland, Noctalia, Fish, Starship, Ghostty, mpv, and Yazi. Yazi includes the Noctalia flavor and the Mediainfo, Ouch, Chmod, and Smart Filter plugins. Its opener choices include Gwenview, GIMP, Satty, Inkscape, Okular, Ark, LibreOffice, and other desktop applications; these are launch commands, not bundled application settings.

This configuration requires Noctalia Shell 5 or later. Noctalia provides the bar, launcher, control center, notifications, media and volume controls, brightness controls, clipboard, screenshots, and session actions. Its bar configuration includes a clock, active-window title, media, network, volume, tray, notifications, GPU temperature, and RAM widgets.

## Fish shell and portability notes

Fish adds `~/.local/bin` to `PATH`, uses Starship, zoxide, and eza, aliases `grep` to ripgrep, and adds verbose `mv`, `rm`, and `cp` abbreviations. Install these tools separately if you use the Fish config.

Hyprland launches apps through `uwsm app --`. If you do not use UWSM, change `launchPrefix` in `config/hypr/config/binds.lua` and the launch strings in `config/hypr/config/scratchpads.lua`. Check that each referenced executable is installed. These configs do not install applications, plugins, or themes.

Back up your current files before copying. Apply the configs in small groups, then reload Hyprland and validate Noctalia after each change.

## Hyprland layout and displays

The monitor example uses two 1920×1080 outputs side by side: `DP-1` at 144 Hz and `DP-2` at 165 Hz. Workspaces 1–2 are assigned to the first output and 4–5 to the second. Change `MONITOR1`, `MONITOR2`, the modes, positions, and workspace rules to match your hardware before enabling this configuration.

The selected layout is Hyprland's scrolling layout. Its settings are in `config/hypr/config/misc.lua`: `column_width = 0.67`, `focus_fit_method = 1`, and `follow_min_visible = 0.25`. The rest of the Hyprland config is split across `config/hypr/config/` for bindings, scratchpads, rules, input, appearance, workspaces, and startup.

## Hyprland Key bindings

`Super` means the Windows/Command key. These bindings are from `config/hypr/config/binds.lua`.

### Launch and toggle apps

| Binding | Action |
| --- | --- |
| Super+Return | Open Ghostty |
| Super+C | Open VS Code |
| Super+W | Open Google Chrome |
| Super+G | Run `chatgpt` |
| Super+H | Run `hermes desktop` |
| Super+O | Open Obsidian |
| Super+E | Toggle Dolphin in `special:dolphin` |
| Super+T | Toggle Thunderbird in `special:thunderbird` |
| Super+Y | Toggle Yazi in `special:yazi` |
| Super+B | Toggle btop in `special:btop` |
| Super+N | Toggle GNOME Calculator in `special:calculator` |

Yazi, Thunderbird, and Dolphin use tiled windows in their special workspaces. btop and Calculator use floating, centered windows. Each app stays running while hidden.

### Window management and navigation

| Binding | Action |
| --- | --- |
| Super+Q | Close the active window |
| Super+Escape | Kill the active window |
| Super+Alt+Space | Toggle floating mode |
| Super+D | Toggle maximize-style fullscreen (`mode = 1`) |
| Super+F | Toggle fullscreen |
| Super+J | Toggle split layout |
| Super+Arrow keys | Focus the neighboring window |
| Super+Shift+Arrow keys | Move the active window in that direction |
| Alt+Tab | Open Noctalia's window switcher |
| Super+1 / Super+2 | Focus monitor 1 / 2 |
| Super+Shift+1 / Super+Shift+2 | Move the active window to monitor 1 / 2 |
| Super+Alt+1…4 | Focus a workspace number |
| Super+Ctrl+1…4 | Focus a workspace relative to the current one |
| Super+Ctrl+Left / Right | Focus the previous / next workspace |
| Super+Ctrl+Down | Focus the next empty workspace |
| Super+Ctrl+Shift+Left / Right | Move the active window to the previous / next workspace |
| Super+Ctrl+Shift+1…4 | Move the active window by a relative workspace offset |
| Super+mouse wheel | Move between workspaces |
| Super+Ctrl+mouse wheel | Focus previous / next workspace |
| Super+Shift+mouse wheel | Move the active window between monitors |
| Super+Minus / Plus (or keypad - / +) | Zoom out / in |
| Super+Shift+R | Move the active window out of a special workspace |
| Super+Shift+S | Move the active window to the default special workspace |
| Super+S | Toggle the default special workspace |

### Desktop controls

| Binding | Action |
| --- | --- |
| Super+Z | Noctalia settings |
| Super+X | Noctalia control center |
| Alt+Space | Noctalia launcher |
| Super+Space | Toggle input method |
| Super+. | Noctalia emoji picker |
| Super+L | Lock the session |
| Super+Alt+C | Open the session panel |
| Super+Shift+W | Open the wallpaper panel |
| Super+V | Open the clipboard panel |
| Super+A | Open notifications |
| Super+P | Pick a screen color with `hyprpicker` |
| Print | Region screenshot |
| Super+Print | Fullscreen screenshot |
| XF86 volume keys | Change volume or mute through Noctalia |
| XF86 media keys | Play/pause, next, and previous |
| XF86 brightness keys | Change display brightness |