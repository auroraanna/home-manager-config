{
	description = "papojari's NixOS configuration";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager/master";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { nixpkgs, home-manager, ... }:
	let
		pkgs = import nixpkgs {
			config = {
				allowUnfree = true;
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
					./system/configuration-amd.nix
				];
			};
			Cryogonull = lib.nixosSystem {
				system = "aarch64-linux";
				modules = [
					./system/configuration-rpi4.nix
				];
			};
		};
	};
}
