#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function bprint() {
  echo -e "\e[1;34m$1\e[0m"
}

function gprint() {
  echo -e "\e[1;32m$1\e[0m"
}

bprint "Updating system"
sudo pacman --noconfirm --needed -Syu

if ! command -v git &>/dev/null; then
  bprint "Installing git"
  sudo pacman --noconfirm --needed -S git
fi

aurhelper=""

until [ "$aurhelper" = "yay" ] || [ "$aurhelper" = "paru" ]; do
  printf 'AUR helper to use? (yay or paru): '

  if ! IFS= read -r aurhelper; then
    printf '\nNo input detected. Exiting.\n' >&2
    exit 1
  fi

  case "$aurhelper" in
  yay | paru)
    bprint "Installing $aurhelper"
    git clone https://aur.archlinux.org/"$aurhelper".git "$HOME/$aurhelper"
    (cd "$HOME/$aurhelper" && makepkg --noconfirm -si --syncdeps)
    rm -rf "$HOME/$aurhelper"
    ;;
  *)
    printf '  → Invalid choice: %q\n' "$aurhelper"
    ;;
  esac
done

bprint "Installing packages"

while read -r pkg; do
  [[ -z "$pkg" ]] && continue

  if [[ "$pkg" =~ ^# ]]; then
    gprint "── Installing ${pkg#\# } ──"
    continue
  fi

  $aurhelper --noconfirm --needed -S "$pkg"

done <"$SCRIPT_DIR/packages.lst"

bprint "Cloning dotfiles"
git clone --bare --branch dots https://github.com/nablaFox/dotfiles "$HOME/.dotfiles"

dots() {
  git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

dots config --local status.showUntrackedFiles no
dots remote remove origin
dots checkout

bprint "Installing gtk-theme"
git clone https://github.com/vinceliuice/Graphite-gtk-theme "$HOME/gtk-theme"
"$HOME"/gtk-theme/install.sh -c dark --tweaks darker rimless
rm -rf "$HOME/gtk-theme"

bprint "Installing sddm theme"
sudo git clone https://github.com/keyitdev/sddm-flower-theme.git /usr/share/sddm/themes/sddm-flower-theme
sudo cp /usr/share/sddm/themes/sddm-flower-theme/Fonts/* /usr/share/fonts/
sudo cp "$SCRIPT_DIR/sddm/background.jpg" /usr/share/sddm/themes/sddm-flower-theme/Backgrounds/background.jpg
sudo cp "$SCRIPT_DIR/sddm/theme.conf" /usr/share/sddm/themes/sddm-flower-theme/theme.conf
echo "[Theme]
    Current=sddm-flower-theme" | sudo tee /etc/sddm.conf

bprint "Copying useful scripts"
sudo cp "$SCRIPT_DIR"/scripts/* /usr/local/bin

bprint "Setting shell to zsh"
sudo chsh -s "$(which zsh)" "${SUDO_USER:-$USER}"

bprint "Wrapping up"
sudo systemctl enable sddm.service

gprint "All done! You can now reboot your system."
