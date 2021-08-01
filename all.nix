{ config, pkgs, lib, ... }:

{
  # Automatic upgrades
  system.autoUpgrade ={
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
    dates = "daily";
  };

	nix = {
    # Garbage collection
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 4d";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    # Make ready for nix flakes
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  hardware = {
    # Disable Pulseaudio because Pipewire is used
    pulseaudio.enable = false;
  };

  security = {
    # rtkit is optional but recommended
    rtkit.enable = true;
    apparmor = {
      enable = true;
      packages = with pkgs; [
        apparmor-profiles
      ];
    };
  };

  services = {
    fstrim.enable = true;
    dbus.apparmor = "enabled";
    openssh = {
      enable = true;
      passwordAuthentication = false;
    };
    gvfs = {
      enable = true;
    };
    xserver = {
      enable = true;
      # Configure keymap in X11
      layout = "de";
      # Enable touchpad support (enabled default in most desktopManager).
      #libinput.enable = true;
      videoDrivers = [
        "amdgpu"
      ];
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      desktopManager = {
        gnome.enable = true;
      };
    };
    pipewire = {
      enable = true;
      # Support alsa programs
      alsa.enable = true;
      alsa.support32Bit = true;
      # Support pulseaudio programs
      pulse.enable = true;
      # Support JACK programs
      #jack.enable = true;
      # Bluetooth
      media-session.config.bluez-monitor.rules = [
        {
          # Matches all cards
          matches = [
            {
              "device.name" = "~bluez_card.*";
            }
          ];
          actions = {
            "update-props" = {
              "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
              # mSBC is not expected to work on all headset + adapter combinations.
              "bluez5.msbc-support" = true;
            };
          };
        }
        {
          matches = [
            # Matches all sources
            {
              "node.name" = "~bluez_input.*";
            }
            # Matches all outputs
            {
              "node.name" = "~bluez_output.*";
            }
          ];
          actions = {
            "node.pause-on-idle" = false;
          };
        }
      ];
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  console = {
    font = "Lat2-Terminus16";
    # Set your keyboard layout
    keyMap = "de";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];
  };

  environment = {
    variables = {
      CLICOLOR = "TRUE";
      EDITOR = "codium";
      TERM = "xterm-256color";
    };
    shellAliases = {
      ll = "ls -al";
      l="ls -lFh";
      la = "ls -a";
      lr = "ls -tRFh";
      grep = "grep --color=auto";
      dud = "du -d 1 -h";
      duf = "du -sh *";
      help = "man";
    };
    pathsToLink = [ "/libexec" ];
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
      promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    };
    ssh.startAgent = true;
    # enable dconf for setting GTK themes via home manager
    dconf.enable = true;
    java.enable = true;
    light.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    xwayland.enable = true;
    qt5ct.enable = true;
    # Some programs need SUID wrappers, can be configured further or are started in user sessions.
    #mtr.enable = true;
    #gnupg.agent = {
    #	enable = true;
    # enableSSHSupport = true;
    #};
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    papojari = {
      isNormalUser = true;
      home = "/home/papojari";
      description = "papojari";
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "lp"
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILcgisTGLBwRrhdmOIEkFP4K2IjI0KuJ4UoOOdn4KNcy papojari@Cryogonull"
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}