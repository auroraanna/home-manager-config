{ config, pkgs, lib, ... }:

{
  security = {
    # rtkit is optional but recommended
    rtkit.enable = true;
    apparmor = {
      enable = true;
      packages = with pkgs; [
        apparmor-profiles
      ];
    };
  };

  services = {
    dbus.apparmor = "enabled";
    openssh = {
      passwordAuthentication = false;
      permitRootLogin = "no";
    };
  };
}