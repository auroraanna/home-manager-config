{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "papojari";
  home.homeDirectory = "/home/papojari";

  programs = {
    bat.enable = true;
    git = {
      enable = true;
      userName = "papojari";
      userEmail = "papojari-git.ovoid@aleeas.com";
    };
    gpg = {
      enable = true;
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };
  };

  xdg.configFile."locale.conf".text = ''
    LANG=en_US.UTF-8
    LC_TIME=de_DE.UTF-8
    LC_MEASUREMENT=de_DE.UTF-8
    LC_ADDRESS=de_DE.UTF-8
    LC_PAPER=de_DE.UTF-8
    LC_TELEPHONE=de_DE.UTF-8
  '';

  home = {
    sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_TIME = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_ADDRESS = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
    };
    packages = with pkgs; [
      # Wine
      wine-staging lutris-unwrapped
      # Wine both 32- and 64 bit support
      wineWowPackages.staging
      # Games
      minecraft amidst multimc
      osu-lazer
      teeworlds
      superTuxKart superTux
      #mindustry-wayland
      # Web browsers
      brave
      # Creative apps
      blender gimp godot godot-export-templates inkscape audacity avidemux
      # Media processing
      ffmpeg obs-studio
      # Development
      cobalt
      # Other
      exodus gnome.gnome-boxes
      # Password managers
      gnome-passwordsafe
      # Email
      thunderbird-bin
      # Voicechat, Social media, Messaging
      discord mumble teamspeak_client element-desktop signal-desktop
    ];
  };
}
