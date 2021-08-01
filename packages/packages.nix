{ config, pkgs, lib, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Fonts
  fonts.fonts = with pkgs; [
    roboto
    font-awesome-ttf
    nerdfonts
  ];

  environment = {
    systemPackages = with pkgs; [
      # Languages
      zsh rustc
      # CLI
      tmux bat wget kakoune git git-crypt gnupg pinentry-gnome tealdeer stow pandoc youtube-dl ytfzf librespeed-cli sftpman
      # Fetch programs
      freshfetch neofetch
      # System monitors
      bpytop
      # CLI fun
      cmatrix nyancat toilet cowsay lolcat cava
      # Video and image
      pqiv mpv scrcpy
      # Audio
      pavucontrol pulseaudio
      # Wayland, Xorg
      polkit polkit_gnome waybar wofi slurp grim swappy rofi mako libappindicator
      # Theming
      lxappearance materia-theme papirus-icon-theme capitaine-cursors
      # Other
      alacritty gnome.gnome-tweak-tool gnome.gnome-shell-extensions deja-dup gnome.dconf-editor
      # File browsers
      gnome.nautilus cinnamon.nemo xplr
      # Web browsers
      firefox-wayland
      # Password managers
      bitwarden
      # Vulkan
      vulkan-loader mangohud vulkan-tools
      # MTP
      jmtpfs
      # Filesystem stuff
      gparted dosfstools mtools ntfs3g btrfs-progs sshfs
    ];
  };
}