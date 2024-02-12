# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.config/oh-my-zsh"

ZSH_THEME="theme"

ZSH_CACHE_DIR="$HOME/.cache/oh-my-zsh"
if [[ ! -d "$ZSH_CACHE_DIR" ]]; then
  mkdir "$ZSH_CACHE_DIR"
fi

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

plugins=(git)

# defaults
export EDITOR=nvim
export TERMINAL=kitty
export BROWSER=chrome
export VISUAL=nvim

# life improvements
bindkey -v
alias yet="yay -Rn"
alias yeet="yay -Rns"
alias update="sudo pacman -Syu"
alias disks="lsblk"

function try() {
	cd ~/Work
	[ "$1" ] && nvim "$HOME/Work/$1" || nvim "$HOME/Work/try"
}

# editing configs
alias cfz="nvdot ~/.zshrc && source ~/.zshrc"
alias cfn="cd ~/.config/nvim && nvdot" # TODO: should be nvdot ~/.config/nvim
alias cfi="nvdot ~/.config/i3/config"
alias cfp="nvdot ~/.config/picom/picom.conf"

# git
alias g="git"
alias gl="git log --oneline --graph --decorate"
alias gad="git add --all"
alias gcm="git commit -m"
alias gcms="git commit -S -m"
alias gph="git push"
alias gpl="git pull"
alias gcl="git clone"
alias gin="git init"

alias gst="git status"
alias glg="git log -n 5"
alias glgr="git reflog"
alias gdf="git diff"

alias gbr="git branch"
alias gsw="git switch"
alias gch="git checkout"
alias gra="git remote add origin git@github.com:"
alias grs="git remote set-url origin git@github.com:"
alias gan="git commit --amend --no-edit"
alias gaa="gad && gan"
alias gpo='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gupdatef="gaa && gpo -f"

# dotfiles
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dotpush='dot push origin dotfiles'
alias nvdot='GIT_DIR=$HOME/.dotfiles/ GIT_WORK_TREE=$HOME nvim'

# media
alias ytdl="yt-dlp --compat-options youtube-dl -f 'bestvideo+bestaudio' -o '$HOME/Videos/%(title)s.%(ext)s'"
alias ytdl-mp3="yt-dlp --compat-options youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 -o '$HOME/Audio/%(title)s.%(ext)s'"
alias ytp="youtube-viewer --player mpv"
alias spt="spotdl --output $HOME/Music"

# xclip
alias xclipc="xclip -i -selection clip"
alias xclipp="xclip -i selection clipbord -o >"

# other
alias nv="nvim"
alias nvhelp="nv ~/Work/nvhelp"
alias l="ls -l"
alias la="ls -alF"
alias h="history|grep"
alias c="clear"

alias help="cat ~/.zshrc | less"
alias aliases="grep '^alias' ~/.zshrc | less"

alias logout="killall -KILL -u $USER"

alias icat="kitten icat"

# cd
alias ..="cd .."
alias ....="cd ../.."
alias ......="cd ../../.."
alias ........="cd ../../../.."

mkcd() {
    if [ "$#" -lt 1 ]; then
        echo "no arguments provided!"
        return
    elif [ "$#" -gt 1 ]; then
        echo "too many arguments! ignoring extra.."
    fi
    test -d "$1" || mkdir "$1" && cd "$1"
}

# fzf
alias cf='change_folder'
alias of='open_with_fzf'
alias f='vfz'

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

change_folder() {
	echo $1 
    [[ -z $1 ]] && DIR=~ || DIR=$1

    CHOSEN=$(fd . $DIR -H -t d | sed "s|^$DIR||" | fzf --preview="exa -s type --icons {}" --bind="ctrl-space:toggle-preview" --preview-window=,30:hidden)
    
    if [[ -z $CHOSEN ]]; then
        echo $CHOSEN
        return 1
    else
        cd "$DIR/$CHOSEN"
    fi

    [[ $(ls | wc -l) -le 60 ]] && (pwd; ls)
    return 0
}

open_with_fzf() {
    FILE=$(rg --files | fzf --preview="xdg-prog {}" --bind="ctrl-space:toggle-preview" --preview-window=up,15%)
    [[ -z "$FILE" ]] || (xdg-open "$FILE" &> /dev/null)
}

_fzf_compgen_path() {
  fd --hidden --follow . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow . "$1"
}

# grep
grept() {
	if [ $# -eq 1 ]; then
		grep -rnw . -e $1
		return
	else
		grep -rnw $1 -e $2
	fi
}

# the fuck
eval $(thefuck --alias)

# custom paths
export PATH=$PATH:~/bin

# bun completions
[ -s "/home/icecube/.bun/_bun" ] && source "/home/icecube/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
