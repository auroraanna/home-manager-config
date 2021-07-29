{ config, pkgs, ... }:

{
	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	# Home Manager needs a bit of information about you and the
	# paths it should manage.
	home.username = "papojari";
	home.homeDirectory = "/home/papojari";

	programs = {
		git = {
			enable = true;
			userName = "papojari";
			userEmail = "papojari-git.ovoid@aleeas.com";
		};
		gpg = {
			enable = true;
		};
	};

	services = {
		gpg-agent = {
			enable = true;
			pinentryFlavor = "gnome3";
		};
	};

	nixpkgs.config = {
		allowUnfree = true;
		packageOverrides = pkgs: {
			# Steam
			steam = pkgs.steam.override {
				nativeOnly = true;
			};
		};
	};

	home.packages = with pkgs; [
		# Wine
		wine-staging lutris-unwrapped
		# Wine both 32- and 64 bit support
		wineWowPackages.staging
		# Games
		minecraft multimc amidst
		osu-lazer
		steam-tui
		teeworlds
		superTuxKart superTux
		# MultiMC
		#(multimc.overrideAttrs (old: {
		#	buildInputs = with pkgs; [ libsForQt5.qt5.qtbase jdk11 zlib ];
		#}))
		#mindustry-wayland
		# Web browsers
		brave tor-browser-bundle-bin
		# Creative apps
		blender gimp godot godot-export-templates inkscape audacity
		# Media processing
		ffmpeg obs-studio
		# Development
		atom cobalt vscodium
		# Other
		exodus gnome.gnome-boxes alacritty
		# Password managers
		gnome-passwordsafe
		# Email
		thunderbird-bin
		# Voicechat, Social media, Messaging
		discord mumble teamspeak_client element-desktop signal-desktop
	];

	# This value determines the Home Manager release that your
	# configuration is compatible with. This helps avoid breakage
	# when a new Home Manager release introduces backwards
	# incompatible changes.
	#
	# You can update Home Manager without changing this value. See
	# the Home Manager release notes for a list of state version
	# changes in each release.
	home.stateVersion = "21.11";
}
