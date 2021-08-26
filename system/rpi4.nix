# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  boot = {
    loader = {
      raspberryPi = {
        enable = true;
        version = 4;
        firmwareConfig = "dtoverlay=vc4-kms-v3d";
      };
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
    kernelPackages = pkgs.linuxPackages_rpi4;
    tmpOnTmpfs = true;
    initrd.availableKernelModules = [ "usbhid" "usb_storage" "vc4" ];
    # ttyAMA0 is the serial console broken out to the GPIO
    kernelParams = [
      "8250.nr_uarts=1"
      "console=ttyAMA0,115200"
      "console=tty1"
      # Some gui programs need this
      "cma=128M"
    ];
  };

  hardware = {
    # Enable GPU acceleration
    raspberry-pi."4".fkms-3d.enable = true;
    # Required for the Wireless firmware
    enableRedistributableFirmware = true;
  };

  fileSystems = {
    "/tmp" = {
      device = "tmpfs";
      options = [
        "rw"
        "nodev"
        "nosuid"
        "size=5G"
      ];
    };
  };

  services = {
    xserver = {
      # Enable touchpad support (enabled default in most desktopManager).
      #libinput.enable = true;
      # X uses ... video driver
      #videoDrivers = [ "fbdev" ];
    };
  };

  i18n = {
    extraLocaleSettings = {
      LANGUAGE = "en_US.UTF-8";
      LC_TIME = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_ADDRESS = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # papojari
  users.users.papojari = {
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcgywMb4yGH8ZN97LBa9P7Q4/3O9GVy/kjtGrV7KFaV papojari@Cryogonal" ];
  };
}
