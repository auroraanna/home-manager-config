{ config, pkgs, lib, ... }:

{
  networking = {
    hostName = "Cryogonull";
    interfaces.eth0.useDHCP = true;
    # Firewall
    firewall = {
      allowedTCPPorts = [
        # Web traffic
        80 443
	    ];
    };
  };
}