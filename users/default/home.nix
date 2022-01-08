{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  imports = [
    ./alacritty.nix
    ./mako.nix
    ./git.nix
    ./neofetch/default.nix
    ./swappy.nix
    ./sway/default.nix
    ./waybar/default.nix
    ./wofi/default.nix
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
