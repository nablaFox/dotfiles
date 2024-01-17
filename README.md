# Dotfiles

![demo 1](https://raw.githubusercontent.com/nablaFox/dotfiles/main/screenshots/demo1.png)

![demo 2](https://raw.githubusercontent.com/nablaFox/dotfiles/main/screenshots/demo2.png)

![demo 3](https://raw.githubusercontent.com/nablaFox/dotfiles/main/screenshots/demo3.png)

## Information

- WM: [i3](https://github.com/i3/i3)
- Terminal: [kitty](https://sw.kovidgoyal.net/kitty/)
- GTK theme: [Graphite-gtk-theme](https://github.com/vinceliuice/Graphite-gtk-theme)
- Grub theme: [Graphite-grub-theme](https://github.com/vinceliuice/Graphite-gtk-theme/tree/main/other/grub2)
- Sddm theme: [ssdm-flower-theme](https://github.com/Keyitdev/sddm-flower-theme)
- Icon theme: [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- Shell: [zsh](https://www.zsh.org/)
- Top bar: made with [eww](https://github.com/elkowar/eww)
- App launcher: [rofi](https://github.com/davatorium/rofi)

## How to Install

> [!CAUTION]
> Avoid running the script on systems with existing desktop environments. <br>
> The script will also modifies your grub config.

After a minimal Arch install run:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/nablaFox/dotfiles/main/install.sh)"
```

> [!TIP]
> You can  also create your own list (for ex. custom_apps.lst) with all your favourite apps, and pass the file to install it:
> ```sh
> sh -c "$(curl -fsSL https://raw.githubusercontent.com/nablaFox/dotfiles/main/install.sh) /path/to/your_list"
> ```

Reboot and enjoy 🍀

## How to use

|Keys|Action|
|:----|:----|
|<kbd>Super</kbd> + <kbd>Return</kbd>|Open terminal (kitty)|
|<kbd>Super</kbd> + <kbd>Q</kbd>|Close active/focused window|
|<kbd>Super</kbd> + <kbd>V</kbd>|Open Neovim in kitty|
|<kbd>Super</kbd> + <kbd>E</kbd>|Open ranger in kitty|
|<kbd>Super</kbd> + <kbd>C</kbd>|Open Google Chrome|
|<kbd>Super</kbd> + <kbd>Tab</kbd>|Focus on the left window|
|<kbd>Super</kbd> + <kbd>J</kbd>|Focus down|
|<kbd>Super</kbd> + <kbd>K</kbd>|Focus up|
|<kbd>Super</kbd> + <kbd>H</kbd>|Focus left|
|<kbd>Super</kbd> + <kbd>L</kbd>|Focus right|
|<kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>direction</kbd>|Move focused window|
|<kbd>Alt</kbd> + <kbd>V</kbd>|Split horizontally|
|<kbd>Alt</kbd> + <kbd>H</kbd>|Split vertically|
|<kbd>Alt</kbd> + <kbd>Return</kbd>|Toggle fullscreen|
|<kbd>Alt</kbd> + <kbd>Q</kbd>|Stacked layout|
|<kbd>Alt</kbd> + <kbd>W</kbd>|Tabbed layout|
|<kbd>Alt</kbd> + <kbd>E</kbd>|Toggle split layout|
|<kbd>Super</kbd> + <kbd>T</kbd>|Restore layout with i3-resurrect|
|<kbd>Super</kbd> + <kbd>Y</kbd>|Save layout with i3-resurrect|
|<kbd>Super</kbd> + <kbd>Space</kbd>|Toggle tiling/floating|
|<kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>Space</kbd>|Change focus between tiling/floating windows|
|<kbd>Super</kbd> + <kbd>I</kbd>|Run lockscreen|
|<kbd>Super</kbd> + <kbd>P</kbd>/<kbd>O</kbd>|Toggle eww bar|
|<kbd>Super</kbd> + <kbd>A</kbd>/<kbd>D</kbd>/<kbd>S</kbd>|Open rofi with various configurations|
|<kbd>Super</kbd> + <kbd>Z</kbd>/<kbd>X</kbd>/<kbd>M</kbd>|Various rofi utilities (power menu, screenshot, mpc)|
|<kbd>Pause</kbd>/<kbd>Print</kbd>|Screenshot actions|
|<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>M</kbd>|Toggle mute|
|<kbd>Ctrl</kbd> + <kbd>F3</kbd>/<kbd>F4</kbd>|Toggle microphone mute/unmute|
|<kbd>Super</kbd> + Number|Switch to workspace|
|<kbd>Super</kbd> + <kbd>Shift</kbd> + Number|Move container to workspace|
|<kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd>|Reload configuration|
|<kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd>|Restart i3 in-place|
|<kbd>Super</kbd> + <kbd>Escape</kbd>|Exit i3|
|<kbd>Super</kbd> + <kbd>R</kbd>|Enter resize mode|
|<kbd>Super</kbd> + <kbd>G</kbd>|Enter gaps mode|

## Packages

The [packages.lst](https://github.com/nablaFox/dotfiles/blob/main/packages.lst) file lists all the packages the script will install. Here's a quick overview of what each package is used for:

<table>
  <tr>
    <td>xorg</td>
    <td>The Graphical interface</td>
  </tr>
  <tr>
    <td>xorg-xinit</td>
    <td>For starting xorg</td>
  </tr>
  <tr>
    <td>xdotool</td>
    <td>Needed by some scripts in <code>scripts</code></td>
  </tr>
  <tr>
    <td>i3-gaps</td>
    <td>Window manager (i3) with gaps</td>
  </tr>
  <tr>
    <td>i3lock-color</td>
    <td>Customizable screen lock</td>
  </tr>
  <tr>
    <td>sddm</td>
    <td>Login display manager</td>
  </tr>
  <tr>
    <td>picom</td>
    <td>Window effects compositor (transaprency, shaodws, ecc.)</td>
  </tr>
  <tr>
  <tr>
    <td>btop</td>
    <td>System resource monitor</td>
  </tr>
  <tr>
    <td>eww</td>
    <td>For custom widgets (like the topbar)</td>
  </tr>
  <tr>
    <td>rofi</td>
    <td>App launcher and window switcher</td>
  </tr>
  <tr>
    <td>dunst</td>
    <td>Graphical notification daemon</td>
  </tr>
  <tr>
    <td>feh</td>
    <td>Wallpaper app</td>
  </tr>
  <tr>
    <td>mpv</td>
    <td>Media player</td>
  </tr>
  <tr>
    <td>mpd</td>
    <td>Music player daemon</td>
  </tr>
  <tr>
    <td>mpc</td>
    <td>CLI for mpd</td>
  </tr>
  <tr>
    <td>kitty</td>
    <td>The terminal</td>
  </tr>
</table>

<table>
  <tr>
    <td>alsa-utils</td>
    <td>Needed for audio</td>
  </tr>
  <tr>
    <td>pulseaudio</td>
    <td>Sound server</td>
  </tr>
  <tr>
    <td>pulseaudio-alsa</td>
    <td>ALSA configuration for using PulseAudio</td>
  </tr>
  <tr>
    <td>pavucontrol</td>
    <td>GUI for managing sound settings</td>
  </tr>
</table>

<table>
  <tr>
    <td>zsh</td>
    <td>Main shell</td>
  </tr>
  <tr>
    <td>oh-my-zsh-git</td>
    <td>For zsh plugins</td>
  </tr>
  <tr>
    <td>zsh-autosuggestions</td>
    <td>Suggests commands as you type in zsh</td>
  </tr>
  <tr>
    <td>zsh-syntax-highlighting</td>
    <td>Provides syntax highlighting zsh</td>
  </tr>
</table>

<table>
  <tr>
    <td>fd</td>
    <td>Fast alternative to 'find'</td>
  </tr>
  <tr>
    <td>ripgrep</td>
    <td>Like 'grep' optimized for speed and efficiency</td>
  </tr>
  <tr>
    <td>fzf</td>
    <td>Fuzzy finder</td>
  </tr>

  <tr>
    <td>thefuck</td>
    <td>Corrects errors in terminal</td>
  </tr>
  <tr>
    <td>neofetch</td>
    <td>For flexing arch</td>
  </tr>
  <tr>
    <td>zathura</td>
    <td>Minimalistic PDF's viewer</td>
  </tr>

  <tr>
    <td>slop</td>
    <td>For screenshots</td>
  </tr>
  <tr>
    <td>xclip</td>
    <td>Ctrl-c/Ctrl-v on steroids</td>
  </tr>
</table>

## Work In Progress

- don't stop the installation if a custom apps fails to install
- eww eventbutton padding
- controlpanel, powermenu, launcher
- music in eww bar
- neovim alpha dynamic padding
- ranger
- other screenshots
- change i3 with i3-gaps

## Credits

- [Hyprdots](https://github.com/prasanthrangan/hyprdots )
- [Keyitdev](https://github.com/Keyitdev/dotfiles)
- [rusty-electron](https://github.com/rusty-electron/dotfiles)
- [gh0stzk](https://github.com/gh0stzk/dotfiles)
