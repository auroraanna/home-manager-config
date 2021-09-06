{ config, pkgs, ... }:

{
  home.file.".config/sway/config".source = ./config;
  home.file.".cache/backgrounds/highway-to-shell.png".source = ../../../backgrounds/highway-to-shell.png;
  home.file.".config/sway/drive-mount.sh".source = ./drive-mount.sh;
  home.file.".config/sway/drive-unmount.sh".source = ./drive-unmount.sh;
  home.file.".config/sway/scan-barcode.sh".source = ./scan-barcode.sh;
  home.file.".config/sway/color-picker.sh".source = ./color-picker.sh;
  home.file.".config/sway/screenshot.sh".source = ./screenshot.sh;
}
