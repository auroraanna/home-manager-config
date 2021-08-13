{ config, pkgs, lib, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    papojari = {
      isNormalUser = true;
      home = "/home/papojari";
      description = "papojari";
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "lp"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILcgisTGLBwRrhdmOIEkFP4K2IjI0KuJ4UoOOdn4KNcy papojari@Cryogonull"
      ];
    };
  };
}