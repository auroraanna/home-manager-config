{ config, pkgs, lib, ... }:

{
	environment.systemPackages = with pkgs; [
		obs-studio
	];

  boot.kernelModules = [ "v4l2loopback" ];

  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback.out
  ];
}