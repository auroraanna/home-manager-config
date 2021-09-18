{ config, pkgs, fetchurl, ... }:

{
  home = {
    file = {
      ".config/sway/config".source = ./config;
      ".cache/backgrounds/highway-to-shell.png".source = ../../../backgrounds/highway-to-shell.png;
      #".cache/backgrounds/nix-wallpaper-3d-showcase.png".source = builtins.fetchurl {
      #  url = https://raw.githubusercontent.com/papojari/nixos-artwork/master/wallpapers/nix-wallpaper-3d-showcase-1920x1080.png;
      #  sha256 = "43b0007ad592de52b927713cfea832f80322808cd274422411228e07066db417";
      #};
      ".cache/backgrounds/nix-wallpaper-3d-showcase.png".source = builtins.fetchurl {
        url = https://raw.githubusercontent.com/papojari/nixos-artwork/master/wallpapers/nix-wallpaper-3d-showcase-2560x1440.png;
        sha256 = "14ad3c27d43d23ab672c0455d4501bb2a0e1f26caaae38ac9e2638ed98f7c410";
      };
      #".cache/backgrounds/nix-wallpaper-3d-showcase.png".source = builtins.fetchurl {
      #  url = https://raw.githubusercontent.com/papojari/nixos-artwork/master/wallpapers/nix-wallpaper-3d-showcase-3840x2160.png;
      #  sha256 = "35376f1c95424580c3d3c3f1843b047789be389bff689285bf1948fe36d84779";
      #};
      ".config/sway/drive-mount.sh".source = ./drive-mount.sh;
      ".config/sway/drive-unmount.sh".source = ./drive-unmount.sh;
      ".config/sway/scan-barcode.sh".source = ./scan-barcode.sh;
      ".config/sway/color-picker.sh".source = ./color-picker.sh;
      ".config/sway/screenshot.sh".source = ./screenshot.sh;
    };
  };
}
