# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
			# Home manager
			#(import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
		];

	boot = {
		loader = {
			systemd-boot = {
				enable = true;
				configurationLimit = 4;
				consoleMode = "max";
				memtest86.enable = true;
			};
			efi.canTouchEfiVariables = true;
		};
		# Enable amdgpu for Southern Islands (SI) cards
		kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" ];
		# Video drivers
		initrd.kernelModules = [ "amdgpu" ];
	};

	# Microcode
	hardware.cpu.amd.updateMicrocode = true;

	# Enable vulkan
	hardware = {
		opengl = {
			driSupport = true;
			driSupport32Bit = true;
		};
	};

	# Networking
	networking = {
		hostName = "Cryogonal";
		nameservers = [ "1.1.1.1" "9.9.9.9" ];
		#resolvconf.enable = false;
		# The global useDHCP flag is deprecated, therefore explicitly set to false here.
		# Per-interface useDHCP will be mandatory in the future, so this generated config
		# replicates the default behaviour.
		useDHCP = false;
		interfaces.enp5s0.useDHCP = true;
		# If using dhcpcd:
		dhcpcd.extraConfig = "nohook resolv.conf";
		# If using NetworkManager:
		#networkmanager.dns = "none";
		#wireless.enable = true;	# Enables wireless support via wpa_supplicant.
		# Configure network proxy if necessary
		#networking.proxy.default = "http://user:password@proxy:port/";
		#networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
	};
	## dnscrypt-proxy2
	services.dnscrypt-proxy2 = {
		enable = true;
		settings = {
			ipv6_servers = true;
			require_dnssec = true;
			sources.public-resolvers = {
				urls = [
					"https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
					"https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
				];
				cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
				minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
			};

			# You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
			# server_names = [ ... ];
		};
	};

	systemd.services.dnscrypt-proxy2.serviceConfig = {
		StateDirectory = "dnscrypt-proxy";
	};

	# Set your time zone.
	time.timeZone = "Europe/Berlin";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		keyMap = "de";
	};

	services.xserver = {
		enable = true;
		# Configure keymap in X11
		layout = "de";
		xkbOptions = "eurosign:e";
		# X uses amdgpu video driver
		videoDrivers = [ "amdgpu" ];
		displayManager = {
			# Enable the GNOME 40 Desktop Environment.
			#wayland = true;
			gdm = {
				enable = true;
				wayland = true;
			};
			#gnome.enable = true;
		};
	};

	services.printing = {
		# Enable CUPS to print documents.
		enable = true;
		# Driver
		drivers = with pkgs; [ hplipWithPlugin ];
	};

	# Audio
	## Disable pulseaudio
	hardware.pulseaudio.enable = false;
	## rtkit is optional but recommended
	security.rtkit.enable = true;
	## Pipewire
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		## If you want to use JACK applications, uncomment this
		#jack.enable = true;
		## Bluetooth
		media-session.config.bluez-monitor.rules = [
			{
				# Matches all cards
				matches = [ { "device.name" = "~bluez_card.*"; } ];
				actions = {
					"update-props" = {
						"bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
						# mSBC is not expected to work on all headset + adapter combinations.
						"bluez5.msbc-support" = true;
					};
				};
			}
			{
				matches = [
				# Matches all sources
				{ "node.name" = "~bluez_input.*"; }
				# Matches all outputs
				{ "node.name" = "~bluez_output.*"; }
				];
				actions = {
				"node.pause-on-idle" = false;
				};
			}
		];
	};

	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;

	programs = {
		zsh = {
			enable = true;
			enableCompletion = true;
			syntaxHighlighting.enable = true;
			autosuggestions.enable = true;
			promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
		};
		# enable dconf for setting GTK themes via home manager
		dconf.enable = true;
		light.enable = true;
		sway = {
			enable = true;
		};
		xwayland.enable = true;
		qt5ct.enable = true;
		steam.enable = true;
	};

	# Define a user account. Don't forget to set a password with ‘passwd’.
	## papojari
	users.users.papojari = {
	isNormalUser = true;
	home = "/home/papojari";
	description = "papojari";
	extraGroups = [ "wheel" "networkmanager" "video" ];
	shell = pkgs.zsh;
	openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcgywMb4yGH8ZN97LBa9P7Q4/3O9GVy/kjtGrV7KFaV papojari@Cryogonal" ];
	};
	#home-manager.users.papojari = {
	#	programs = {
	#		git = {
	#			enable = true;
	#			userName	= "papojari";
	#			userEmail = "papojari-git.ovoid@aleeas.com";
	#		};
	#		alacritty = {
	#			enable = true;
#	settings = {
#		window.dimensions = {
 #	 		lines = 3;
	#			columns = 200;
	 #			 };
	 #		 };
 #		 };
 #	 wayland.windowManager = {
#			sway = {
	#			enable = true;
#	config = {
#
#	};
 #		 };
	#	};
	#};

	# Automatic upgrades
	system.autoUpgrade.enable = true;

	# Allow unfree packages (sorry stallman)
	nixpkgs.config.allowUnfree = true;

	# OpenCL and Vulkan
	hardware.opengl.extraPackages = with pkgs; [
		rocm-opencl-icd
		rocm-opencl-runtime
		amdvlk
	];
	# For 32 bit applications
	# Only available on unstable
	hardware.opengl.extraPackages32 = with pkgs; [
		driversi686Linux.amdvlk
	];

	nixpkgs.config.allowBroken = true;

	# Steam
	nixpkgs.config.packageOverrides = pkgs: {
		steam = pkgs.steam.override {
			nativeOnly = true;
		};
	};

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		 # Languages
		 zsh zsh-syntax-highlighting zsh-autosuggestions zsh-powerlevel10k dash rustc
		 # CLI
		 tmux cmatrix toilet cowsay wget kakoune neovim neofetch htop cava git tealdeer stow unzip pandoc youtube-dl ytfzf xplr
		 # Video and image
		 pqiv mpv scrcpy
		 # Audio
		 pipewire pavucontrol pulseaudio
		 # Wine
		 wine-staging
		 # Wine both 32- and 64 bit support
		 wineWowPackages.staging
		 # Wayland, Xorg
		 wayland xwayland xorg.xrdb polkit polkit_gnome waybar wofi slurp grim swappy alacritty
		 # Theming
		 papirus-icon-theme lxappearance qt5ct materia-theme capitaine-cursors pywal
		 # Apps
		 alacritty gnome.nautilus cinnamon.nemo gnome.gnome-tweak-tool gnome.gvfs
		 brave bitwarden gnome-passwordsafe ferdi spotify exodus minecraft lunar-client discord mumble
		 # E-Mail
		 gnome.geary thunderbird-bin
		 # Media processing
		 ffmpeg obs-studio
		 # Development
		 atom cobalt
		 # Creative
		 blender gimp godot godot-export-templates inkscape audacity
		 # Office
		 libreoffice-fresh
		 # Vulkan
		 vulkan-loader mangohud
		 # Games
		 teeworlds
		 superTuxKart
		 superTux
		 #m-wayland
		 # MTP
		 jmtpfs
		 # KDE Connect
		 gparted dosfstools mtools
		 # Printing & scanning
		 cups system-config-printer gnome.simple-scan
	];

	environment.pathsToLink = [ "/libexec" ];

	# Fonts
	fonts.fonts = with pkgs; [
		roboto roboto-mono roboto-mono
		ubuntu_font_family
		font-awesome-ttf
		nerdfonts
	];

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#	 enable = true;
	#	 enableSSHSupport = true;
	# };

	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	# services.openssh.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "21.11"; # Did you read the comment?

}
