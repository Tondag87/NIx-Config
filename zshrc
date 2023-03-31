
source ~/.config/zsh/.zprofile

export EDITOR='nvim'
export TERMINAL='alacritty'
export BROWSER='firefox'
export TERM="alacritty"

PROMPT='%F{blue}  %1~%f%F{grey} |%  '

neofetch

#Aliases
alias v='nvim'
alias nix-config='sudo nvim /etc/nixos/configuration.nix'
alias rebuild='sudo nixos-rebuild switch'
alias term='nvim ~/.config/alacritty/alacritty.yml'
alias b='nvim ~/.config/bspwm/bspwmrc'
alias p='nvim ~/.config/picom/picom.conf'
alias sx='nvim ~/.config/sxhkd/sxhkdrc'
alias nvc='cd ~/.config/nvim'
alias ls='exa --icons'
