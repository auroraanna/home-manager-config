{ config, pkgs, lib, ... }:

{
  hardware.opengl = {
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

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}