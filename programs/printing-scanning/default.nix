{ config, pkgs, lib, ... }:

{
  hardware = {
    sane = {
      enable = true;
    };
  };

  services = {
    printing = {
      # Enable CUPS to print documents.
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    system-config-printer
    gnome.simple-scan
  ];
}
