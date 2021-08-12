{ config, pkgs, ... }:

{
  home.file.".config/sway/config".source = ./config;
  home.file.".config/sway/screenshot.sh".source = ./screenshot.sh;
  home.file.".config/sway/scan-barcode.sh".source = ./scan-barcode.sh;
  home.file.".config/sway/color-picker.sh".source = ./color-picker.sh;
}
