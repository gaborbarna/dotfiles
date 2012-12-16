#if [ "$TMUX" = "" ]; then tmux; fi
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/lesbroot/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=20000
SAVEHIST=20000
# End of lines configured by zsh-newuser-install
#

[[ -x /usr/bin/keychain ]] && eval $(keychain --eval --agents ssh -Q --quiet id_ecdsa)
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi
if [ "$(whoami)" = "root" ]; then NCOLOR="red"; else NCOLOR="white"; fi

PROMPT="%{$fg[$NCOLOR]%}%B%n%b%{$reset_color%}:%{$fg[blue]%}%B%c/%b%{$reset_color%} "
RPROMPT="[%*]"

bindkey -e
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[5~" history-search-backward
bindkey "^[[6~" history-search-forward

eval `dircolors .dircolors`
export GREP_COLOR="1;33"
export TERM=xterm-256color
export EDITOR="vim"

#clojure
export CLOJURE_EXT=~/.clojure
export LD_LIBRARY_PATH=/usr/local/lib
#export LD_LIBRARY_PATH=/usr/lib
export PATH=$PATH:/usr/share/clojure
export PATH=$PATH:~/Build/clojure-contrib/launchers/bash
export PATH=$PATH:~/Build/leiningen
export PATH=$PATH:/opt/maven/bin
export PATH=$PATH:/.gem/ruby/1.9.1/bin
export GEM_HOME="~/.gem/ruby/1.9.1"

alias mc='mc -S /usr/share/mc/skins/solarized.ini'
alias clj=clj-env-dir
alias cpufreq-custom='@ cpufreq-set -c 0 -u 1600MHz -d 800MHz -g ondemand; @ cpufreq-set -c 1 -u 1600MHz -d 800MHz -g ondemand'
alias clr='clear'
alias cls='clear'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..="cd ../"
alias ..\/..="cd ../../"
alias @="sudo"
alias ll="ls -lh"
alias l="ls -lh"
alias la="ls -a"
alias lla="ls -lha"
alias exit="clear; exit"
alias x="startx"
alias wlan_sweethome='sudo netcfg2 sweethome'
alias VBoxModules='sudo modprobe vboxdrv; sudo modprobe vboxnetflt'
alias pacup="sudo pacman -Syu"
alias pac="sudo pacman -S"
alias pac-cutleaves="sudo pacman -Qqdt"
alias ural2="ssh bg870@ural2.hszk.bme.hu -p 22"
alias k2net="ssh lesbroot@212.40.75.145 -p 6222"
alias k3net="ssh lesbroot@k3net.hu -p 6222"
alias centaur="ssh lesbroot@centaur.sch.bme.hu -p 22"
alias sshtunnel="ssh -ND 8787 -v lesbroot@k2net.hu -p 6222"
alias sshtunnel2="ssh -ND 8787 -v lesbroot@centaur.sch.bme.hu -p 22"
alias wget="wget -c"
alias p="ping"
alias vi="vim"
alias mu="mutt"
alias xpdf="xpdf"
alias cpuinfo='watch -n 1 grep \"cpu MHz\" /proc/cpuinfo'
alias dicthu='dict -d hun-eng'
alias dicten='dict -d eng-hun'
alias startx='startx &> ~/.xlog'
# colorized pacman output with pacs alias:
alias pacs="pacsearch"
pacsearch() {
   echo -e "$(pacman -Ss "$@" | sed \
        -e 's#^core/.*#\\033[0;31m&\\033[0;37m#g' \
	-e 's#^extra/.*#\\033[0;32m&\\033[0;37m#g' \
	-e 's#^community/.*#\\033[0;35m&\\033[0;37m#g' \
	-e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g' ) \
	\033[0m"
}

extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar e $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

setopt autocd

export LC_MESSAGES="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"

export AWT_TOOLKIT=MToolkit

autoload -U promptinit
promptinit

