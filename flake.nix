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
            ./users/default/home.nix
            ./users/default/alacritty.nix
            ./users/default/mako.nix
            ./users/default/neofetch/default.nix
            ./users/default/swappy.nix
            ./users/default/sway/default.nix
            ./users/default/waybar/default.nix
            ./users/default/wofi/default.nix
            ./users/default/starship/default.nix
            ./users/papojari/home.nix
            ./users/default/xdg.nix
            ./.secrets/users/papojari/zsh/default.nix
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
          ./.secrets/users/amd.nix
          ./network/default.nix
          ./network/amd.nix
          ./packages/default.nix
          ./packages/extra.nix
          ./programs/default.nix
          ./programs/zsh.nix
          ./programs/openrgb.nix
          ./programs/steam.nix
          ./programs/audio.nix
          ./programs/sql.nix
          ./programs/printing/default.nix
          ./programs/printing/hplip.nix
          ./fonts.nix
          ./default.nix
        ];
      };
      Cryogonull = lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          nixos-hardware.nixosModules.raspberry-pi-4
          ./hardware/rpi4.nix
          ./system/rpi4.nix
          ./network/default.nix
          ./network/rpi4.nix
          ./packages/default.nix
          ./default.nix
          ./fonts.nix
          ./programs/default.nix
          ./programs/zsh.nix
          ./programs/audio.nix
        ];
      };
    };
  };
}
