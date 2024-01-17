#!/bin/bash

BLUE="\033[0;34m"
RESET="\033[0m"
GREEN="\033[0;32m"
RED="\033[0;31m"
BOLD="\033[1m"
ABORT=0
LOG_FILE="$HOME/dotfiles.log"

error_msg() {
	echo -e "\n${RED}Installation failed${RESET} ($ABORT)"
	echo -e "${BOLD}Please check $LOG_FILE for more details${RESET}"
	sudo rm -rf "$HOME/deps" "$HOME/dotfiles"
}

end_spinner() {
	echo -en "\033[2K\r"
	if [ $ABORT -ne 0 ]; then
		error_msg
		exit $ABORT
	else
		echo -e "\r[${GREEN}ok${RESET}] ${SPIN_MSG}"
	fi

	kill $SPINNER_PID
}

spinner() {
	local frames=('-' '\\' '|' '/')
	SPIN_MSG="$1"
	(
		while true; do
			for frame in "${frames[@]}"; do
				echo -ne "\r${BLUE}${frame}${RESET} ${SPIN_MSG}"
				sleep 0.08
			done
		done
	) &
	SPINNER_PID=$!

	shift

	trap "ABORT=130 end_spinner" SIGINT SIGTERM
	"$@" >>"$LOG_FILE" 2>>"$LOG_FILE"

	local result=$?
	if [ $result -ne 0 ]; then
		ABORT=$result
	fi

	end_spinner
}

catch() {
	trap "return 1" ERR
}

clean() {
	rm -rf "$HOME/deps" "$HOME/dotfiles"
	exit 1
}

system_update() {
	trap "exit 1" ERR
	echo -e "${BLUE}Updating system${RESET}\n"
	sleep 1
	sudo pacman --noconfirm --needed -Sy archlinux-keyring
	sudo pacman --noconfirm --needed -Syu
	sudo pacman --noconfirm --needed -S base-devel git curl
}

install_dotfiles() {
	catch
	git clone --recurse-submodules --depth 1 https://github.com/nablaFox/dotfiles ~/dotfiles
	cd ~/dotfiles || exit 1
	SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
}

install_aur_helper() {
	if ! command -v "$aurhelper" &>/dev/null; then
		trap "exit 1" ERR

		echo -e "\nIt seems that you don't have $aurhelper installed. Let's solve this.\n"
		echo -e "${BLUE}Installing $aurhelper${RESET}\n"
		sleep 0.5

		git clone https://aur.archlinux.org/"$aurhelper".git "$HOME/deps/$aurhelper"
		cd "$HOME/deps/$aurhelper" && makepkg -si --noconfirm
	fi
}

install_from_file() {
	while read -r pkg; do
		if [[ $pkg == \#* ]] || [[ -z $pkg ]]; then
			continue
		fi

		local msg="Installing $pkg"
		if pacman -Ss "$pkg" &>/dev/null; then
			spinner "$msg" sudo pacman --noconfirm --needed -S "$pkg"
		else
			spinner "$msg" "$aurhelper" -S --noconfirm --needed "$pkg"
		fi
	done <"$1"
}

install_pkgs() {
	install_from_file "$SCRIPT_DIR"/packages.lst
}

install_custom_apps() {
	custom_apps=${1:-$SCRIPT_DIR/custom_apps.lst}
	install_from_file "$custom_apps"
}

install_fonts() {
	trap "clean" ERR
	echo -e "\n${BLUE}Installing fonts${RESET}\n"
	$aurhelper --needed --noconfirm -S ttf-hack-nerd ttf-cascadia-code-nerd ttf-roboto consolas-font ttf-opensans noto-fonts-emoji noto-fonts ttf-iosevka-nerd nerd-fonts-noto-sans-regular-complete
	cp -r "$SCRIPT_DIR/dotfiles/.fonts" "$HOME/.fonts"
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
	sudo cp "$SCRIPT_DIR/sddm/background.jpg" /usr/share/sddm/themes/sddm-flower-theme/Backgrounds/background.jpg
	sudo cp "$SCRIPT_DIR/sddm/theme.conf" /usr/share/sddm/themes/sddm-flower-theme/theme.conf
}

install_eww() {
	trap "clean" ERR
	echo -e "\n${BLUE}Installing eww${RESET}\n"
	$aurhelper -S --noconfirm --needed gtk-layer-shell eww-x11 gd jq libpng
}

create_default_dirs() {
	mkdir -p "$HOME"/{.config,Pictures/wallpapers}
	mkdir -p /usr/local/bin
}

copy_configs() {
	catch
	cp -r "$SCRIPT_DIR"/dotfiles/.config/* "$HOME"/.config/
	cp -r "$SCRIPT_DIR"/dotfiles/Pictures/* "$HOME"/Pictures/
	find "$SCRIPT_DIR"/dotfiles/ -maxdepth 1 -type f -name ".*" -exec cp {} "$HOME/" \;
}

copy_scripts() {
	sudo cp -r "$SCRIPT_DIR"/scripts/* /usr/local/bin/
	sudo chmod +x /usr/local/bin/*
}

finishing() {
	trap "clean" ERR
	echo -e "\n${BLUE}Finishing${RESET}\n"
	chsh -s /bin/zsh
	[[ -d /usr/share/oh-my-zsh ]] && sudo mv /usr/share/oh-my-zsh "$HOME"/.oh-my-zsh
	sudo chsh -s /bin/zsh
	sudo rm -rf ~/deps
	sudo chown -R "$USER":"$USER" "$HOME"
}

ask() {
	read -rp "$(echo -e "\e[1m$1\e[0m [Y/n]") " answer
	[[ $answer =~ ^[Nn]$ ]]
}

banner() {
	echo -e "${BLUE}
 ____      _   ___ _ _      
|    \ ___| |_|  _|_| |___ ___ 
|  |  | . |  _|  _| | | -_|_ -|
|____/|___|_| |_| |_|_|___|___|

${RESET}From icecube with love <3\n"
}

get_aurhelper() {
	while true; do
		read -rp $'\e[1mWhich aur helper do you use? [yay/paru]\e[0m (default yay) ' aurhelper
		aurhelper=${aurhelper:-yay}

		[[ $aurhelper =~ ^(yay|paru)$ ]] && break || echo -e "\e[1mPlease enter a valid aur helper [yay/paru]\e[0m"
	done
}

get_choices() {
	choices=(1 2 3 4 5 6 7 8 9 10 11 12 13 14)

	if ! ask "\nProceeding with default installation?"; then
		return 0
	fi

	echo -e "Ok then! Here are the options:\n"

	declare -A options=(
		[1]="Update system"
		[5]="Install custom apps"
		[6]="Install fonts"
		[7]="Install grub theme"
		[8]="Install sddm theme"
		[9]="Install gtk theme"
	)

	for index in "${!options[@]}"; do
		label=${options[$index]}

		if ask "$label"; then
			for i in "${!choices[@]}"; do
				if [[ ${choices[i]} == "$index" ]]; then
					unset 'choices[i]'
				fi
			done
		fi
	done

	IFS=$'\n' read -r -d '' -a choices < <(printf '%s\n' "${choices[@]}" | sort -n)
	unset IFS
}

main() {
	for choice in "${choices[@]}"; do
		case $choice in
		1) system_update ;;
		2) install_aur_helper ;;
		3) spinner "Installing dotfiles" install_dotfiles ;;
		4) install_pkgs ;;
		5) install_custom_apps "$@" ;;
		6) install_fonts ;;
		7) spinner "Installing gtk_theme" install_gtk_theme ;;
		8) spinner "Installing grub_theme" install_grub_theme ;;
		9) spinner "Installing sddm theme" install_sddm_theme ;;
		10) spinner "Creating default dirs" create_default_dirs ;;
		11) install_eww ;;
		12) spinner "Copying configs" copy_configs ;;
		13) spinner "Copying scripts" copy_scripts ;;
		14) finishing ;;
		esac
	done

	echo -e "\n${GREEN}*All Done!${RESET} You may reboot now."
}

banner

get_aurhelper

get_choices

main "$@"
