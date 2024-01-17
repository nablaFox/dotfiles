# Dotfiles

![demo 1](https://raw.githubusercontent.com/nablaFox/dotfiles/main/screenshots/demo1.png)

![demo 2](https://raw.githubusercontent.com/nablaFox/dotfiles/main/screenshots/demo2.png)

<!-- other demos -->

## Information

## Installation

> [!CAUTION] 
> The script modifies your grub config.
> This script is also designed to be run after a minimal arch installation. Don't use it on a previously installed desktop.

After a minimal Arch install (with grub and systemd), clone and execute -

```sh
pacman -Sy git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/nablaFox/dotfiles/main/install.sh)"
```

you can also pass a list of custom packages to install, like this:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/nablaFox/dotfiles/main/install.sh) /path/to/your_list"
```

## Keybindings


## Packages


## Credits

- https://github.com/Keyitdev/dotfiles
- https://github.com/rusty-electron/dotfiles
- https://github.com/gh0stzk/dotfiles

## TODO

- music notifications
- README
- eww bar launcher, controlpanel, powermenu
- more demos
- icons
- dynamic padding
- eww install
- music in eww bar
