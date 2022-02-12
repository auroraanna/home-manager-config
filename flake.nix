{
  description = "papojari's Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    home-manager = {
      url = "github:nix-community/home-manager";
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
    };
    lib = nixpkgs.lib;
  in {
    homeConfigurations = {
      papojari = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/papojari";
        username = "papojari";
        configuration = {
          imports = [
            ./users/papojari/home.nix
          ];
        };
        stateVersion = "21.11";
      };
    };
  };
}
