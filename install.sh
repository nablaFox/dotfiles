#!/bin/bash

BLUE="\033[0;34m"
RESET="\033[0m"
GREEN="\033[0;32m"
RED="\033[0;31m"
BOLD="\033[1m"
ABORT=0

end_spinner() {
    echo -en "\033[2K\r"
    if [ $ABORT -ne 0 ]; then
        echo -e "\r[${RED}x${RESET}] ${SPIN_MSG}"
		echo -e "\n${RED}Installation failed${RESET}"
		echo -e "${BOLD}Please check $SCRIPT_DIR/errors.log for more details${RESET}"
		sudo rm -rf $HOME/deps $HOME/dotfiles
		kill $SPINNER_PID
		exit $ABORT
    else
        echo -e "\r[${GREEN}ok${RESET}] ${SPIN_MSG}"
    fi

	kill $SPINNER_PID
}

spinner() {
    local frames=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    SPIN_MSG="$1"
    (	
        while true; do
            for frame in "${frames[@]}"; do
                echo -ne "\r${BLUE}${frame}${RESET} ${SPIN_MSG}"
                sleep 0.08
            done
        done
    ) & SPINNER_PID=$!

    shift

	trap "ABORT=130 end_spinner" SIGINT SIGTERM
    "$@" > /dev/null 2>> errors.log

	local result=$?
	if [ $result -ne 0 ]; then
		ABORT=$result
	fi

	end_spinner
}

catch() {
	trap "return 1" ERR
}

system_update() {
	catch
	pacman --noconfirm --needed -Sy archlinux-keyring
	pacman --noconfirm --needed -Syu
	pacman -S --needed --noconfirm wget git curl
}

install_dotfiles() {
	catch
	git clone --recurse-submodules --depth 1 https://github.com/nablaFox/dotfiles ~/dotfiles
	cd ~/dotfiles
	SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
}

install_aur_helper() {
	catch
	if ! command -v "$aurhelper" &> /dev/null; then
		git clone https://aur.archlinux.org/"$aurhelper".git $HOME/deps/"$aurhelper"
		cd $HOME/deps/$aurhelper && makepkg -si --noconfirm
	fi	
}

install_from_file() {
	cat "$1" | while read -r pkg; do
		if [[ $pkg == \#* ]] || [[ -z $pkg ]]; then
			continue
		fi

		local msg="Installing $pkg"
		if pacman -Ss "$pkg" &> /dev/null; then
			spinner "$msg" sudo pacman --noconfirm --needed -S "$pkg" 
		else
			spinner "$msg" $aurhelper -S --noconfirm --needed "$pkg"
		fi
    done
}

install_pkgs() {
	install_from_file "$SCRIPT_DIR"/packages.lst
}

install_custom_apps() {
	custom_apps=${1:-$SCRIPT_DIR/custom_apps.lst}
	install_from_file $SCRIPT_DIR/custom_apps.lst
}

install_fonts() {
	$aurhelper --needed --noconfirm -S ttf-hack-nerd ttf-cascadia-code-nerd ttf-roboto consolas-font ttf-opensans noto-fonts-emoji noto-fonts ttf-iosevka-nerd
	fc-cache -fv
}

install_gtk_theme() {
	catch
	git clone https://github.com/vinceliuice/Graphite-gtk-theme ~/deps/gtk-theme 
	~/deps/gtk-theme/install.sh -c dark --tweaks darker rimless
}

install_grub_theme() {
	catch
	~/deps/gtk-theme/other/grub2/install.sh
	sudo cp "$SCRIPT_DIR/grub/background.png" "/usr/share/grub/themes/Graphite/background.png"
}

install_sddm_theme() {	
	catch
	$aurhelper -S --noconfirm --needed sddm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg sddm
	sudo systemctl enable sddm.service
	sudo git clone https://github.com/keyitdev/sddm-flower-theme.git /usr/share/sddm/themes/sddm-flower-theme
	sudo cp /usr/share/sddm/themes/sddm-flower-theme/Fonts/* /usr/share/fonts/
	echo "[Theme]
    Current=sddm-flower-theme" | sudo tee /etc/sddm.conf
	sudo cp $SCRIPT_DIR/sddm/background.jpg /usr/share/sddm/themes/sddm-flower-theme/Backgrounds/background.jpg
	sudo cp $SCRIPT_DIR/sddm/theme.conf /usr/share/sddm/themes/sddm-flower-theme/theme.conf
}

create_default_dirs() {
	mkdir -p "$HOME"/.config
	catch	
	sudo mkdir -p /usr/local/bin
	mkdir -p "$HOME"/Pictures/wallpapers
}

copy_configs() {
	catch
	sudo cp -r $SCRIPT_DIR/dotfiles/.config/* "$HOME"/.config/
	find "$SCRIPT_DIR/dotfiles/" -maxdepth 1 -type f -name ".*" -exec cp {} "$HOME/" \;
}

copy_scripts() {
	sudo cp -r $SCRIPT_DIR/scripts/* /usr/local/bin/
}

finishing () {
	catch
	chsh -s /bin/zsh
	sudo rm -rf ~/deps
}

ask() {
    read -p "$(echo -e "\e[1m$2\e[0m [Y/n]") " answer
    [[ $answer =~ ^[Yy]$ ]]
}

banner="$(cat << EOF
 ____      _   ___ _ _      
|    \ ___| |_|  _|_| |___ ___ 
|  |  | . |  _|  _| | | -_|_ -|
|____/|___|_| |_| |_|_|___|___|
EOF
)"

echo -e "${BLUE}$banner${RESET}"                        
echo -e "\nFrom icecube with love <3\n"

while true; do
    read -p $'\e[1mWhich aur helper do you use? [yay/paru]\e[0m (default yay) ' aurhelper
    aurhelper=${aurhelper:-yay}

    [[ $aurhelper =~ ^(yay|paru)$ ]] && break || echo -e "\e[1mPlease enter a valid aur helper [yay/paru]\e[0m"
done

options=(
    1 "Update system"
    5 "Install custom apps"
    7 "Install grub theme"
    8 "Install sddm theme"
    9 "Install gtk theme"
)

choices=(2 3 4 6 10 11 12 13)

for (( i=0; i<${#options[@]}; i+=2 )); do
    index=$((i))
    label=${options[index+1]}
    if ask "${options[index]}" "$label"; then
        choices+=("${options[index]}")
    fi
done

IFS=$'\n' choices=($(sort -n <<<"${choices[*]}"))
unset IFS

for choice in ${choices[@]}; do
	case $choice in
		1) spinner "Updating the system" system_update;;
		2) spinner "Installing dotfiles" install_dotfiles;;
		3) spinner "Installing $aurhelper" install_aur_helper;;
		4) install_pkgs;;
		5) install_custom_apps;;
		6) spinner "Installing fonts" install_fonts;;
		7) spinner "Installing gtk_theme" install_gtk_theme;; 
		8) spinner "Installing grub_theme" install_grub_theme;;
		9) spinner "Installing sddm theme" install_sddm_theme;;
		10) spinner "Creating default dirs" create_default_dirs;;
		11) spinner "Copying configs" copy_configs;;
		12) spinner "Copying scripts" copy_scripts;;
		13) spinner "Finishing" finishing;;
	esac
done

echo -e "\n${GREEN} *All Done!${RESET}"
