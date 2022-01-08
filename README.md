<div align="center">

<h1>papojari's Home Manager configuration</h1>

<p>
  <a href="https://nixos.org/"><img src="https://img.shields.io/badge/NixOS-unstable-blue.svg?style=flat&logo=NixOS&logoColor=white" alt="Badge: NixOS | unstable"/></a>
  <a href="https://swaywm.org/"><img src="https://img.shields.io/badge/Sway-1.6.1-yellowgreen" alt="Badge: Sway | 1.6.1"/></a>

[![built with Nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

This repository contains my Home Manager configuration files. Other than the `*.nix` files you will be able to use all of the files on other operating systems like BSD, macOS or any of the other Linux distributions.

</div>

---

![Screenshot](screenshot.webp)

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

Clone this repository to somewhere, for example: *your home directory*, like this

```bash
git clone https://codeberg.org/papojari/home-manager-config.git
```

Then apply the config with this command:

```bash
./manage.sh --apply
```

### Backgrounds

#### Highway to shell

![Highway to shell backgrounds](https://codeberg.org/papojari/nixos-config/raw/branch/main/backgrounds/HighwayToShell.png)

This is the default wallpaper. You just need to build the Home Manager configuration to look at it in sway.

#### 3d NixOS

![3d NixOS background](https://raw.githubusercontent.com/papojari/nixos-artwork/master/wallpapers/nix-wallpaper-3d-showcase-1920x1080.png)

- to use, uncomment the first `$Background` line and comment the next line in `users/default/sway/config`. The default resolution is `2560` by `1440`. If this does not match your resolution you should comment the current resolution in `users/default/sway/default.nix` and uncomment your desired resolution. Then rebuild with

```bash
./manage.sh --apply-users
```

### Sway

Before you starting to use sway you'll have to adjust the config to you monitor setup. To list your monitors run
```bash
swaymsg -t get_outputs
```
and then adjust the identifiers like `DP-1` or `HDMI-A-1`, resolutions and positions in `users/default/sway/default.nix` in the `wayland.windowManager.sway.config.output` section. Then rebuild with

```bash
./manage.sh --apply-users
```

You can just start *sway* with `sway` in a tty. Alternatively start *sway* from a display manager. ~In my experience, despite what the wiki says, *gdm* works.~ Don't use gdm though. It breaks gvfs.

### How to hide your secrets in this repository

If you want to fork this repository and configure it to your liking you may want to put secrets in some files. I've put mine in `.secrets`. This folder is useless to you since it is encrypted.

The next to sub headings describe 2 ways in which you can encrypt your `.secrets`. `git-crypt` is more convenient. But first, follow the next steps.

1. ```bash
   rm .secrets .git-crypt
   ```

2. Put your secrets in `.secrets`.

3. If there are nix files in `.secrets` you may want to import them in the other nix files.

### via `git-crypt`

```bash
git-crypt init
```

### via `age`

Before doing commits with `git` you should run
```bash
./manage.sh --lock
```
to encrypt the secrets with a password. Otherwise your secrets won't be secrets anymore so be careful, if your secrets are included in the commit. Put that password in a password manager like Bitwarden. You'll need it to unencrypt your secrets with
```bash
./manage.sh --unlock
```
as you might've guessed by now.

## Licenses

[View this repository's licenses](Licenses.md)

## Credits

Thanks [Wil Taylor](https://github.com/wiltaylor) for teaching me nix flakes and `git crypt` in [your awesome tutorial series](https://www.youtube.com/watch?v=QKoQ1gKJY5A&list=PL-saUBvIJzOkjAw_vOac75v-x6EzNzZq-)!
