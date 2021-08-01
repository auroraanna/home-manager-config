{ config, pkgs, lib, ... }:

{
  networking = {
    hostName = "Cryogonal";
    interfaces.enp34s0.useDHCP = true;
    # Firewall
    firewall = {
      # Steam & web traffic
      allowedTCPPorts = [
        80 443 27036
      ];
      allowedUDPPorts = [
        4380 3478 4379 4380
      ];
      allowedUDPPortRanges = [
        {
          from = 27000;
        to = 27100;
        }
      ];
      allowedTCPPortRanges = [
        {
          from = 27015;
          to = 27030;
        }
      ];
    };
  };
}