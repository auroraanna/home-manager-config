<div align="center">

<h1>papojari's NixOS configuration</h1>

<p>
  <a href="https://nixos.org/"><img src="https://img.shields.io/badge/NixOS-unstable-blue" alt="Badge: NixOS | unstable"/></a>
  <a href="https://swaywm.org/"><img src="https://img.shields.io/badge/Sway-1.6.1-yellowgreen" alt="Badge: Sway | 1.6.1"/></a>
  <a href="https://swaywm.org/"><img src="https://img.shields.io/badge/GNU%20Stow-2.3.1-yellow" alt="Badge: GNU Stow | 2.3.1"/></a>  
</p>

[![built with Nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

This repository contains my NixOS desktop configuration files. Other than the `configuration-*.nix` files you will be able to use all of the files on other operating systems like BSD, macOS or any of the other Linux distributions.

</div>

---

## Preview

![Preview](preview.png)

## Getting started

### Installing NixOS

#### x86_64 architecture

1. Follow [NixOS unstable manual](https://nixos.org/manual/nixos/unstable/) until you have a working system.
2. Boot it without the installation medium.

#### Raspberry Pi 4 Model B

1. Follow this [nix.dev turorial](https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi) until you have a working system.
2. Boot from the disk.

### Build `configuration-*.nix`

Copy one of the `configuration-*.nix` to `/etc/nixos/configuration.nix` by downloading one of them with `wget` or cloning the repository. Choose the `configuration-*.nix` based on if you want to install the configuration on a Raspberry Pi 4 Model B or an x86_64 computer, preferably with AMD processor and a AMD Radeon Sea Islands graphics card.

If you're computer is x86_64 but not what I described in the latter of the last sentence you will have to tweak the `configuration-amd.nix` a bit.

Next up rebuild the NixOS installation with

	nixos-rebuild switch --upgrade

### Backgrounds

Everything from here on should be done one the machine, which you installed NixOS with my `configuration.nix` on.

- 3d NixOS background

	![3d NixOS background](https://raw.githubusercontent.com/papojari/nixos-artwork/master/wallpapers/nix-wallpaper-3d-showcase-1920x1080.png)

	- to install run


	git clone https://github.com/papojari/nixos-artwork.git && mkdir -p /usr/share/backgrounds/nixos && mv nixos-artwork/wallpapers/* /usr/share/backgrounds/nixos/ && rm -rf nixos-artwork

### Linking my dotfiles with `stow`

This command clones the repository into your home directory, `cd`'s into the `nixos-config-desktop` folder and simulates the *stowing*.

	git clone https://codeberg.org/papojari/nixos-config-desktop.git ~/ && stow -nvSt ~ ~/nixos-config-desktop/*/

If `stow` reports that some files already exist in the corresponding locations you will have to move them.

The next command will put links in the corresponding locations in your home directory, that will be linking to my configuration.

	stow -vSt ~ ~/nixos-config-desktop/*/

This way you have all the configuration files in one place. This makes publishing your configuration to a repository very easy. If you wanted to you could add your own configuration files and link them with GNU Stow or just edit mine a bit.

Alternatively you could move every single file to its appropriate position given in the repository. For that you would manually have to create all the folders which is time consuming so GNU Stow makes much sense here.

### Wayland

Before you start *sway* adjust `~/.config/sway/config` to you monitor setup. You can just start *sway* with `sway` in a tty. Alternatively start *sway* from a display manager. In my experience, despite what the wiki says, *gdm* works.

#### lxappearance

- In sway open `lxappearance`and set *Materia-dark-compact* as the GTK theme.
- Then set *Papirus-Dark* and as your mouse cursor, select *Capitaine Cursors*.

## License

This repository is [unlicensed](https://unlicense.org/).
