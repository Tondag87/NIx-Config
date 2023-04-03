
source ~/.config/zsh/.zprofile

export EDITOR='nvim'
export TERMINAL='kitty'
export BROWSER='brave'
export TERM="kitty"

PROMPT='%F{blue}  %1~%f%F{white} |%  '

neofetch

#Aliases
alias v='nvim'
alias nixos-config='sudo nvim /etc/nixos/configuration.nix'
alias rebuild='sudo nixos-rebuild switch'
alias term='nvim ~/.config/alacritty/alacritty.yml'
alias b='nvim ~/.config/bspwm/bspwmrc'
alias p='nvim ~/.config/picom/picom.conf'
alias sx='nvim ~/.config/sxhkd/sxhkdrc'
alias nvc='cd ~/.config/nvim'
alias ls='exa --icons'
