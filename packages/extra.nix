{ config, pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # CLI
      radeontop wkhtmltopdf
      # Video and image
      scrcpy
      # Theming
      papirus-icon-theme lxappearance materia-theme capitaine-cursors pywal
      # Other
      gnome.gnome-tweak-tool gnome.gnome-shell-extensions deja-dup gnome.dconf-editor
      # Web browsers
      brave
      # Password managers
      bitwarden
      # Music streaming
      spotify
      # E-Mail
      gnome.geary
      spotify
      # Office
      libreoffice-fresh
      # Vulkan
      mangohud
      # Printing & scanning
      cups system-config-printer gnome.simple-scan
      # Python packages
      python39Packages.pyqt5
    ];
  };
}