{ config, pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # CLI
      radeontop
      # Video and image
      scrcpy
      # Other
      gnome.gnome-tweak-tool gnome.gnome-shell-extensions deja-dup gnome.dconf-editor piper
      # Web browsers
      brave
      # Password managers
      bitwarden
      # Music streaming
      spotify
      # Office
      libreoffice-fresh pdfarranger
      # OCR
      gImageReader
    ];
  };
}