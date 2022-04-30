{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "papojari";
  home.homeDirectory = "/home/papojari";

  imports = [
    ./../default/home.nix
  ];

  programs = {
    bat.enable = true;
    git = {
      userName = "papojari";
      userEmail = "papojari-git.ovoid@aleeas.com";
      signing = {
        key = "5D98BEEC20C9695C";
      };
    };
  };

  home = {
    language.base = "en_US.UTF-8";
    keyboard.layout = "de";
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  home = {
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
      #heroic
      #mindustry-wayland
      # Web browsers
      brave
      # Creative apps
      blender gimp godot godot-export-templates inkscape audacity #avidemux
      # Development
      cobalt zola
      # Other
      exodus gnome.gnome-boxes
      # Password managers
      gnome-passwordsafe
      # Email
      evolution
      # Voicechat, Social media, Messaging
      discord mumble teamspeak_client element-desktop signal-desktop
    ];
  };
}
