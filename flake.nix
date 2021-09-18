{
  description = "papojari's NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixos-hardware, ... }:
  let
    pkgs = import nixpkgs {
      config = {
        # Allow unfree packages (sorry stallman)
        allowUnfree = true;
      };
      localSystem = {
        system = "x86_64-linux";
      };
    };
    lib = nixpkgs.lib;
  in {
    homeManagerConfigurations = {
      papojari = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        inherit pkgs;
        username = "papojari";
        homeDirectory = "/home/papojari";
        configuration = {
          imports = [
            ./users/papojari/home.nix
          ];
        };
      };
    };
    nixosConfigurations = {
      Cryogonal = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./flake-default-modules.nix
          ./hardware/amd.nix
          ./system/amd.nix
          ./.secrets/system/amd.nix
          ./network/amd.nix
          ./packages/extra.nix
          ./programs/openrgb.nix
          ./programs/steam.nix
          ./programs/printing-scanning/default.nix
          ./programs/printing-scanning/hplip.nix
        ];
      };
      Cryogonull = lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./flake-default-modules.nix
          nixos-hardware.nixosModules.raspberry-pi-4
          ./hardware/rpi4.nix
          ./system/rpi4.nix
          ./network/rpi4.nix
        ];
      };
    };
  };
}
