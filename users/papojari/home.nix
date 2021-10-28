{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "papojari";
  home.homeDirectory = "/home/papojari";

  imports = [
    ./../default/home.nix
    ./../../.secrets/users/papojari/zsh/default.nix
  ];

  programs = {
    bat.enable = true;
    git = {
      enable = true;
      userName = "papojari";
      userEmail = "papojari-git.ovoid@aleeas.com";
      signing = {
        signByDefault = true;
        key = "319A982F5F12013B730139FF5D98BEEC20C9695C";
      };
      lfs.enable = true;
      delta.enable = true;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    gpg = {
      enable = true;
    };
    obs-studio.enable = true;
  };

  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };
  };

  home = {
    language.base = "en_US.UTF-8";
    keyboard.layout = "de";
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
      #mindustry-wayland
      # Web browsers
      brave
      # Creative apps
      blender gimp godot godot-export-templates inkscape audacity avidemux
      # Media processing
      ffmpeg
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
