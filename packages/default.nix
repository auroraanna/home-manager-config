{ config, pkgs, lib, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment = {
    systemPackages = with pkgs; [
      # Languages
      zsh rustc jdk
      # Compression tools
      zstd zpaq
      # CLI
      tmux bat wget kakoune git git-crypt git-lfs gnupg pinentry-gnome age tealdeer stow pandoc youtube-dl ytfzf librespeed-cli sftpman zbar imagemagick xorg.xeyes wev sox
      # Prompts
      starship
      # Fetch programs
      freshfetch neofetch
      # System monitors
      bpytop
      # CLI fun
      asciiquarium cmatrix nyancat cbonsai toilet figlet cowsay lolcat cava
      # Video and image
      gthumb mpv mpvScripts.youtube-quality ffmpeg
      # Wayland, Xorg
      wl-clipboard polkit polkit_gnome waybar ulauncher wofi wofi-emoji slurp grim swappy swaylock-fancy notify-desktop mako libappindicator gnome.zenity
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
      # Python
      python39Packages.pyqrcode python39Packages.spotipy python39Packages.pytz
      # SSH askpass
      x11_ssh_askpass
    ];
  };
}
