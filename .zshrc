# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '/home/salt/.zshrc'

autoload -Uz compinit
autoload -Uz tetriscurses
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd
unsetopt beep extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install

setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt AUTO_CD
setopt PROMPT_SUBST

ZLE_RPROMPT_INDENT=0

bindkey '^H'  backward-kill-word
bindkey ';5D' backward-word
bindkey ';5C' forward-word
bindkey ';3D' backward-word
bindkey ';3C' forward-word

alias la='ls -A --color=auto'
alias ll='ls -la --color=auto'
alias ls='ls --color=auto'

alias grep='grep --color -i'
alias more=less
# alias NOW!='shutdown -s -t 0'
alias NOW!='systemctl poweroff'

dots=..; up=..
for i in {2..9}; do
  dots+=.; up+=/..
  alias "$dots"="cd $up"
done
unset dots up i;

# forgot where I got this from, but thanks surface-linux community!
ltefix(){
  readonly CDC_NCM_DIR=/sys/bus/usb/devices/2-3/2-3:1.0/net/wwp0s20f0u3/cdc_ncm
  
  for val in 16383 16384; do
      for max in rx_max tx_max; do
          echo "$val" | sudo tee "${CDC_NCM_DIR}/${max}"
      done
  done
}

hist () {
  fc -ln 0 | grep "$*"
}

api() {
  curl -S 'https://api.ipapi.is/?q='"$*" --silent --max-time 3
}

weather() {
  curl 'wttr.in/'"$*"'?0' --silent --max-time 3
}

git_prompt(){
  git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/"\1"/p'
}

PROMPT='%(?.%F{014}.%F{196})%f%B%F{016}%(?.%K{014}%1~%k.%K{196}%?%k)%f%b%(?.%F{014}.%F{196})%f '
RPROMPT='%(?.%F{014}.%F{196})%f%B%F{016}%(?.%K{014}.%K{196})%(.$(git_prompt).%T.)%k%f%b%(?.%F{014}.%F{196})%f'

# vulkan development
source ~/Development/vulkan-1.4.328.1/setup-env.sh

# bun completions
[ -s "/home/salt/.bun/_bun" ] && source "/home/salt/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias dots='/usr/bin/git --git-dir=$HOME/Projects/dotfiles/ --work-tree=$HOME'

# zsh-syntax-highlighting
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

