
# EXPORTS
export PATH=$HOME/.local/bin/:$PATH
export MANPATH="/usr/local/man:$MANPATH"
export PAGER='most'
export EDITOR=nvim
export VISUAL=nvim
export LCAL=$HOME/.local
export LSRC=$LOCAL/src
export LBIN=$LOCAL/bin
export LSHR=$LOCAL/share
export LLIB=$LOCAL/lib

# ALIASES
alias exs="exa -la"
alias pac="sudo pacman -Sy "
alias pas="sudo pacman -Sy && pacman -Ss"
alias upt="sudo pacman -Syyu"
alias rel="source ~/.zshrc"
alias grep='grep --color=auto'
alias df='df -h'
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias free="free -mt"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias update-fc='sudo fc-cache -fv'
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias jctl="journalctl -p 3 -xb"
alias valcheck="sudo DEBUGINFOD_URLS="https://debuginfod.archlinux.org" G_SLICE=always-malloc valgrind"
# alias update_xres="xrdb -merge ~/.Xresources; xsetroot -name 'fsignal:reloadXresources'; pkill -USR1 st"
# alias valcheck="make >/dev/null 2>&1 && sudo DEBUGINFOD_URLS="https://debuginfod.archlinux.org" G_SLICE=always-malloc valgrind"

# THEMES
ZSH_THEME="random"
ZSH_THEME_RANDOM_CANIDATES=(linuxonly trapd00r xiong-chiamiov-plus mira kardan tjkirch_mod amuse refined dogenpunk frisk \
cypher mlh rkj-repos ys fletcherm steeef pygmalion philips aussiegeek intheloop 3den pygmalion-virtualenv \
awesomepanda dst essembeh wezm+ clean dstufft zhann risto eastwood cloud wedisagree kennethreitz flazz \
lukerandall af-magic mgutz takashiyoshida rgm fox simple sunrise dpoggi jreese mortalscumbag kiwi \
obraun suvash jispwoso xiong-chiamiov candy arrow macovsky-ruby josh gallifrey michelebologna darkblood \
norm sporty_256)

# PLUGINS
plugins=( git vi-mode copypath extract git-extras jsontools colorize zsh-syntax-highlighting zsh-autosuggestions)

# ZSH STUFF
export ZSH=$HOME/repos/other/omz
source $ZSH/oh-my-zsh.sh

export HISTCONTROL=ignoreboth:erasedups
setopt SHARE_HISTORY
setopt GLOB_DOTS

# FUNCTIONS
function ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function pacsi() {
    pkg_inst=$(pacman -Slq | fzf --preview "pacman -Si {}" -m | tr "\n" " " | xargs)
    echo "$pkg_inst" | sudo pacman -S -
}

# AUTO TMUX
if [[ ! -z "$DISPLAY" ]]; then
  if [[ -z "$TMUX" ]]; then
    choice=$(tmux list-sessions | fzf | awk -F':' '{ print $1 }')
    if [[ -z "$choice" ]]; then
      tmux new-session
    else
      tmux attach -t $choice
    fi
  fi
fi
