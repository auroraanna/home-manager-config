{ config, pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # CLI
      radeontop
      # Video and image
      scrcpy
      # Other
      gnome.gnome-tweak-tool gnome.gnome-shell-extensions deja-dup gnome.dconf-editor
      # Web browsers
      brave
      # Password managers
      bitwarden
      # Music streaming
      spotify
      # Office
      libreoffice-fresh pdfslicer
      # Vulkan
      mangohud
      # Printing & scanning
      cups system-config-printer gnome.simple-scan
      # Python packages
      python39Packages.pyqt5
    ];
  };
}