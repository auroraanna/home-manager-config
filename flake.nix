{
  description = "papojari's NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
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
            ./.secrets/users/papojari/home.nix
          ];
        };
      };
    };
    nixosConfigurations = {
      Cryogonal = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware/amd.nix
          ./system/amd.nix
          ./.secrets/system/amd.nix
          ./network/all.nix
          ./network/amd.nix
          ./packages/packages.nix
          ./packages/packages-extra.nix
          ./all.nix
        ];
      };
      Cryogonull = lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hardware/rpi4.nix
          ./system/rpi4.nix
          ./network/all.nix
          ./network/rpi4.nix
          ./packages/packages.nix
          ./all.nix
        ];
      };
    };
  };
}
