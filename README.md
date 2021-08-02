<div align="center">

<h1>papojari's NixOS configuration</h1>

<p>
  <a href="https://nixos.org/"><img src="https://img.shields.io/badge/NixOS-unstable-blue" alt="Badge: NixOS | unstable"/></a>
  <a href="https://swaywm.org/"><img src="https://img.shields.io/badge/Sway-1.6.1-yellowgreen" alt="Badge: Sway | 1.6.1"/></a>

[![built with Nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

This repository contains my NixOS desktop configuration files. Other than the `*.nix` files you will be able to use all of the files on other operating systems like BSD, macOS or any of the other Linux distributions.

</div>

---

## Preview

![Preview](preview.png)

## Stuff used

### Programs

| Type of program      | Type of programs used                                                              |
| -------------------- | ---------------------------------------------------------------------------------- |
| OS                   | [NixOS](https://nixos.org/)                                                        |
| Shell                | [Zsh](https://en.wikipedia.org/wiki/Z_shell/)                                      |
| Display manager      | [GDM](https://wiki.archlinux.org/title/GDM/)                                       |
| Wayland compositor   | [sway](https://swaywm.org/)                                                        |
| Status bar           | [Waybar](https://github.com/Alexays/Waybar/)                                       |
| Application launcher | [Wofi](https://hg.sr.ht/~scoopta/wofi/)                                            |
| Terminal emulator    | [Alacritty](https://github.com/alacritty/alacritty/)                               |
| Text editor          | [VSCodium](https://vscodium.com/), [Kakoune](https://kakoune.org/)                 |
| Web browser          | [Brave](https://brave.com/), [Firefox](https://www.mozilla.org/en-US/firefox/new/) |

### Fonts

- Roboto
- Font Awesome
- Iosevka (Nerdfont)

## Getting started

### Installing NixOS with my configuration

#### x86_64 architecture

1. Follow [NixOS unstable manual](https://nixos.org/manual/nixos/unstable/) until you have a working system.
2. Boot it without the installation medium.

#### Raspberry Pi 4 Model B

1. Follow this [nix.dev turorial](https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi) until you have a working system.
2. Boot from the disk.

### Building from the Nix files

Clone this repository to somewhere, for example: *your home directory*, like this

```bash
git clone https://codeberg.org/papojari/nixos-config-desktop.git
```

#### NixOS

My configuration is specifically made for two system so If you don't have a computer with an AMD CPU and an AMD Sea Islands GPU or a Raspberry Pi 4 you'll have to adjust some files.

What configuration will be built when you run

```bash
./apply-system.sh
```

is determined by your hostname so change your hostname or the files depending or which should be built.

#### Home Manager

```bash
./apply-users
```

### Linking my dotfiles with `stow`

Do

```bash
./stow.sh
```

in the repository.

This way you have all the configuration files in one place. This makes publishing your configuration to a repository very easy. If you wanted to you could add your own configuration files and link them with GNU Stow or just edit mine a bit.

Alternatively you could move every single file to its appropriate position given in the repository. For that you would manually have to create all the folders which is time consuming so GNU Stow makes much sense here.

If you ever want to unstow, do

```bash
./unstow.sh
```

in the repository.

### Backgrounds

Everything from here on should be done one the machine, which you installed NixOS with my `configuration.nix` on.

- Highway to shell

	![Highway to shell backgrounds](https://codeberg.org/papojari/nixos-config-desktop/raw/branch/main/backgrounds/HighwayToShell.png)

	- run this to to copy the background you already downloaded to the backgrounds folder

	```bash
	cp ~/nixos-config-desktop/backgrounds/HighwayToShell.png /usr/share/backgrounds
	```

- 3d NixOS

	![3d NixOS background](https://raw.githubusercontent.com/papojari/nixos-artwork/master/wallpapers/nix-wallpaper-3d-showcase-1920x1080.png)

	- to install run

	```bash
	git clone https://github.com/papojari/nixos-artwork.git && mkdir -p /usr/share/backgrounds/nixos && mv nixos-artwork/wallpapers/* /usr/share/backgrounds/nixos/ && rm -rf nixos-artwork
	```

	- to use uncomment the first `$Background` line and comment the next line in `~/.config/sway/config`

### Wayland

Before you start *sway* adjust `~/.config/sway/config` to you monitor setup. You can just start *sway* with `sway` in a tty. Alternatively start *sway* from a display manager. In my experience, despite what the wiki says, *gdm* works.

#### lxappearance

- In sway open `lxappearance`and set *Materia-dark-compact* as the GTK theme.
- Then set *Papirus-Dark* and as your mouse cursor, select *Capitaine Cursors*.

## Licenses

[View this repository's licenses](https://codeberg.org/papojari/nixos-config-desktop/src/branch/main/Licenses.md)

## Credits

Thanks [Wil Taylor](https://github.com/wiltaylor) for teaching me nix flakes and `git crypt` in [your awesome tutorial series](https://www.youtube.com/watch?v=QKoQ1gKJY5A&list=PL-saUBvIJzOkjAw_vOac75v-x6EzNzZq-)!