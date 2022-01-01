{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    tealdeer
  ];

  systemd.services.tldr = {
    enable = true;
    description = "Update tldr";
    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgs.tealdeer}/bin/tldr --update";
      Restart = "always";
      RestartSec = 5400;
    };
    wantedBy = [ "multi-user.target" ];
  };
}