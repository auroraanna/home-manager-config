{ config, pkgs, lib, ... }:

{
  # Automatic upgrades
  system.autoUpgrade ={
    enable = true;
    allowReboot = true;
    flake = "codeberg:papojari/nixos-config";
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

  services = {
    fstrim.enable = true;
    ratbagd.enable = true;
    pcscd.enable = true;
    openssh = {
      enable = true;
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
        defaultSession = "sway";
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      desktopManager = {
        gnome.enable = true;
      };
    };
    gnome = {
      sushi.enable = true;
      gnome-keyring.enable = true;
    };
    transmission.enable = true;
    flatpak.enable = true;
  };

  programs = {
    ssh = {
      startAgent = false;
    };
    gnupg.agent = {
      enable = true;
      pinentryFlavor = "gtk2";
      enableSSHSupport = true;
    };
    # enable dconf for setting GTK themes via home manager
    dconf.enable = true;
    java.enable = true;
    light.enable = true;
    xwayland.enable = true;
    wshowkeys.enable = false;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    file-roller.enable = true;
    seahorse.enable = true;
    gnome-disks.enable = true;
    #gnome-documents.enable = true;
    evince.enable = true;
    geary.enable = true;
    kdeconnect.enable = true;
    # Some programs need SUID wrappers, can be configured further or are started in user sessions.
    #mtr.enable = true;
  };

  qt5 = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  xdg = {
    portal.wlr.enable = true;
  };
}
