{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./alacritty.nix
    ./mako.nix
    ./git.nix
    ./neofetch/default.nix
    ./swappy.nix
    ./sway/default.nix
    ./waybar/default.nix
    ./starship/default.nix
    ./xdg.nix
    ./gtk.nix
    ./cursor.nix
    ./vscode.nix
    ./mangohud.nix
    ./chromium.nix
    ./kitty/default.nix
  ];
}
