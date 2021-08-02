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
            ./users/default/home.nix
            ./users/default/alacritty.nix
            ./users/default/mako.nix
            ./users/default/neofetch/default.nix
            ./users/default/swappy.nix
            ./users/default/sway/default.nix
            ./users/default/waybar/default.nix
            ./users/default/wofi/default.nix
            ./users/default/zsh/default.nix
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
          ./network/default.nix
          ./network/amd.nix
          ./packages/default.nix
          ./packages/extra.nix
          ./default.nix
        ];
      };
      Cryogonull = lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hardware/rpi4.nix
          ./system/rpi4.nix
          ./network/default.nix
          ./network/rpi4.nix
          ./packages/default.nix
          ./default.nix
        ];
      };
    };
  };
}
