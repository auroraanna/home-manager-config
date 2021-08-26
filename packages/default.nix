{ config, pkgs, lib, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment = {
    systemPackages = with pkgs; [
      # Languages
      zsh rustc jdk
      # Compression algorithms
      zstd zpaqd
      # CLI
      tmux bat wget kakoune git git-crypt git-lfs gnupg pinentry-gnome age tealdeer stow pandoc youtube-dl ytfzf librespeed-cli sftpman zbar imagemagick
      # Prompts
      starship
      # Fetch programs
      freshfetch neofetch
      # System monitors
      bpytop
      # CLI fun
      cmatrix nyancat cbonsai toilet cowsay lolcat cava
      # Video and image
      gthumb mpv ffmpeg avidemux
      # Display managers
      libsForQt5.sddm-kcm
      # Wayland, Xorg
      wl-clipboard polkit polkit_gnome waybar wofi wofi-emoji slurp grim swappy swaylock-fancy notify-desktop mako libappindicator gnome.zenity
      # Theming
      lxappearance materia-theme papirus-icon-theme capitaine-cursors
      # Other
      alacritty gnome.gnome-tweak-tool gnome.gnome-shell-extensions deja-dup gnome.dconf-editor transmission-gtk
      # File browsers
      gnome.nautilus cinnamon.nemo xplr
      # Web browsers
      firefox-wayland
      # Vulkan
      vulkan-loader vulkan-tools
      # Filesystem stuff
      gparted dosfstools mtools ntfs3g btrfs-progs sshfs jmtpfs
    ];
  };
}