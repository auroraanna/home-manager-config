# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "hplip"
    ];
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 8;
        consoleMode = "max";
        memtest86.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
    # Enable amdgpu for Southern Islands (SI) cards
    kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" ];
    # Video drivers
    initrd.kernelModules = [ "amdgpu" ];
  };

  hardware = {
    # Microcode
    cpu.amd.updateMicrocode = true;
    # OpenGL & Vulkan
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
        amdvlk
      ];
      # For 32 bit applications
      # Only available on unstable
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
    sane = {
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
    };
  };

  # Mounting
  fileSystems = {
    "/backgrounds" = {
      device = "/dev/disk/by-uuid/9feb2ea8-a1c5-4dc7-866e-402437d2489f";
      fsType = "btrfs";
      options = [ "subvolid=329" ];
    };
    "/games/ssd-btrfs" = {
      device = "/dev/disk/by-uuid/9feb2ea8-a1c5-4dc7-866e-402437d2489f";
      fsType = "btrfs";
      options = [ "subvolid=331" ];
    };
    "/git-repos" = {
      device = "/dev/disk/by-uuid/9feb2ea8-a1c5-4dc7-866e-402437d2489f";
      fsType = "btrfs";
      options = [ "subvolid=1007" ];
    };
    "/data" = {
      device = "/dev/disk/by-uuid/9feb2ea8-a1c5-4dc7-866e-402437d2489f";
      fsType = "btrfs";
      options = [ "subvolid=356" ];
    };
    "/stick" = {
      device = "/dev/disk/by-uuid/9feb2ea8-a1c5-4dc7-866e-402437d2489f";
      fsType = "btrfs";
      options = [ "subvolid=436" ];
    };
    "/srv" = {
      device = "/dev/disk/by-uuid/9feb2ea8-a1c5-4dc7-866e-402437d2489f";
      fsType = "btrfs";
      options = [ "subvolid=1016" ];
    };
    "/video-download" = {
      device = "/dev/disk/by-uuid/2b2f4aec-9d14-450e-93c4-b5f7d8dafafa";
      fsType = "btrfs";
      options = [ "subvolid=336" ];
    };
    "/images" = {
      device = "/dev/disk/by-uuid/2b2f4aec-9d14-450e-93c4-b5f7d8dafafa";
      fsType = "btrfs";
      options = [ "subvolid=335" ];
    };
    "/ginkgo" = {
      device = "/dev/disk/by-uuid/2b2f4aec-9d14-450e-93c4-b5f7d8dafafa";
      fsType = "btrfs";
      options = [ "subvolid=354" ];
    };
    "/games/hdd-btrfs" = {
      device = "/dev/disk/by-uuid/2b2f4aec-9d14-450e-93c4-b5f7d8dafafa";
      fsType = "btrfs";
      options = [ "subvolid=328" ];
    };
    "/games/hdd-ntfs" = {
      device = "/dev/disk/by-uuid/5C2CF7652CF7389A";
      fsType = "ntfs";
    };
  };

  services = {
    xserver = {
      videoDrivers = [
        "amdgpu"
      ];
    };
    printing = {
      # Enable CUPS to print documents.
      enable = true;
      # Driver
      drivers = with pkgs; [
        hplipWithPlugin
      ];
    };
  };

  i18n = {
    extraLocaleSettings = {
      LANG = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_ADDRESS = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
    };
  };

  programs = {
    steam.enable = true;
  };
}
