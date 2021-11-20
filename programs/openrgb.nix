{ config, pkgs, ... }:

let
  openrgb-rules = builtins.fetchurl {
    url = "https://gitlab.com/CalcProgrammer1/OpenRGB/-/raw/master/60-openrgb.rules";
    sha256 = "1rfpaaiymxrpvyx1mcqx5zzh3ndqcmskg29z7cw9j7afp7w2qx8s";
  };
in {
  environment.systemPackages = with pkgs; [
    openrgb
  ];

  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];

  services.udev.extraRules =  builtins.readFile openrgb-rules;
}