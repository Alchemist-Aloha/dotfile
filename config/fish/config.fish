# Cachyos default
#source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
   # smth smth
end

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
