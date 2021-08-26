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
}
