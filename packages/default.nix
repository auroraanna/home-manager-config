{ config, pkgs, lib, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment = {
    systemPackages = with pkgs; [
      # Languages
      zsh rustc jdk
      # CLI
      tmux bat wget git git-crypt git-lfs gnupg age tealdeer youtube-dl ytfzf librespeed-cli zbar imagemagick xorg.xeyes wev sox trash-cli pinentry-curses exa zoxide fd ripgrep bat-extras.batdiff bat-extras.batgrep bat-extras.batman bat-extras.batwatch bat-extras.prettybat monolith ventoy-bin
      ## Compression tools
      zstd zpaq
      ## Prompts
      starship
      ## Fetch programs
      freshfetch neofetch
      ## System monitors
      bpytop
      ## Fun
      asciiquarium cmatrix nyancat cbonsai toilet figlet cowsay lolcat cava
      # Video and image
      gthumb mpv ffmpeg
      # Wayland, Xorg
      wl-clipboard polkit polkit_gnome
      # Other
      alacritty deja-dup transmission-gtk
      # File browsers
      cinnamon.nemo
      # Web browsers
      firefox-wayland
      # Vulkan
      vulkan-loader vulkan-tools
      # Filesystem stuff
      gparted dosfstools mtools ntfs3g btrfs-progs jmtpfs
    ];
  };
}
