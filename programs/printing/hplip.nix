{ config, pkgs, lib, ... }:

{
  hardware = {
    sane = {
      extraBackends = [ pkgs.hplipWithPlugin ];
    };
  };

  services = {
    printing = {
      # Enable CUPS to print documents.
      # Driver
      drivers = with pkgs; [
        hplipWithPlugin
      ];
    };
  };
}
