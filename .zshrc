# zsh customization
ZSH_CUSTOM="$HOME/.config/oh-my-zsh/"

ZSH_THEME=keyitdev

plugins=(git)

source /usr/share/oh-my-zsh/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# env variables
export SHELL=$(which zsh)
export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=kitty
export BROWSER=chromium

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

# ricing
alias dots='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias rice='GIT_DIR=$HOME/.dotfiles/ GIT_WORK_TREE=$HOME nvim'
alias cfz="rice ~/.zshrc && source ~/.zshrc"
alias cfn="rice ~/.config/nvim"
alias cfi="rice ~/.config/i3"

# media
alias ytdl="yt-dlp --compat-options youtube-dl -f 'bestvideo+bestaudio' -o '$HOME/Videos/%(title)s.%(ext)s'"
alias ytdl-mp3="yt-dlp --compat-options youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 -o '$HOME/Audio/%(title)s.%(ext)s'"
alias ytp="youtube-viewer --player mpv"
alias spt="spotdl --output $HOME/Music"

# xclip
alias xclipc="xclip -i -selection clip"
alias xclipp="xclip -i selection clipbord -o >"

# fzf
alias cf='cd_fzf'
alias of='open_fzf'
alias f='edit_fzf'

cd_fzf() {
  local DIR="${1:-$HOME}"
  local TARGET=$(find "$DIR" -type d -printf '%P\n' | fzf) || return 1
  cd "$DIR/${TARGET}" 
}

open_fzf() {
    local FILE=$(rg --files | fzf --preview="xdg-prog {}" --bind="ctrl-space:toggle-preview" --preview-window=up,15%)
    [[ -z "$FILE" ]] || (xdg-open "$FILE" &> /dev/null)
}

edit_fzf() {
    local DIR="${1:-.}"

    local SUDO="$([ "$(stat -c %U "$DIR")" = "root" ] && echo 'sudo' || echo '')"
    local EDITOR="$([ "$SUDO" = "sudo" ] && echo 'sudoedit' || echo "${EDITOR:-vi}")"

    local FILE=$($SUDO rg --files --hidden "$DIR" | $SUDO fzf --preview="bat {}" --bind="ctrl-space:toggle-preview" --preview-window=:hidden)

    [ -z "$FILE" ] || ${EDITOR} "$FILE"
}

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# tweaks
alias nv="nvim"
alias l="ls -l"
alias la="ls -alF"
alias c="clear"

alias help="cat ~/.zshrc | less"

alias logout="killall -KILL -u $USER"
alias icat="kitten icat"

bindkey -v
alias yet="yay -Rn"
alias yeet="yay -Rns"
alias update="sudo pacman -Syu"
alias disks="lsblk"

alias ..="cd .."
alias ....="cd ../.."
alias ......="cd ../../.."
alias ........="cd ../../../.."
