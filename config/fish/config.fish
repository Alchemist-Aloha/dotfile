source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
   # smth smth
end

export ANDROID_HOME=$HOME/develop/Android/Sdk
fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path $HOME/develop/flutter/bin
# uv
fish_add_path "$HOME/.local/bin"

alias ls='eza -a'
alias ll='eza -la'
alias la='eza -la'
alias lla='eza -la'
alias lt='eza --tree'

alias grep='rg'

export EDITOR=fresh
# zoxide (fast directory jumper)
if type -q zoxide
    zoxide init fish | source
end
alias cd='z'

# Starship
starship init fish | source

# mv, rm, cp
abbr mv 'mv -v'
abbr rm 'rm -v'
abbr cp 'cp -v'

# Added by Antigravity CLI installer
set -gx PATH "$HOME/.local/bin" $PATH

# Pi
fish_add_path "$HOME/.pi/agent/bin"
