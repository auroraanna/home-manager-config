# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[
			# Include the results of the hardware scan and enable Raspberry Pi 4 profile
			<nixos-hardware/raspberry-pi/4>
			./hardware-configuration-rpi4.nix
			# home-manager
			(import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
		];

	boot = {
		loader = {
			raspberryPi = {
				enable = true;
				version = 4;
				firmwareConfig = "dtoverlay=vc4-kms-v3d";
			};
			grub.enable = false;
			generic-extlinux-compatible.enable = true;
		};
		kernelPackages = pkgs.linuxPackages_rpi4;
		tmpOnTmpfs = true;
		initrd.availableKernelModules = [ "usbhid" "usb_storage" "vc4" ];
		# ttyAMA0 is the serial console broken out to the GPIO
		kernelParams = [
			"8250.nr_uarts=1"
			"console=ttyAMA0,115200"
			"console=tty1"
			# Some gui programs need this
			"cma=128M"
		];
	};


	hardware = {
		# Enable vulkan
		#opengl = {
		#	driSupport = true;
		#	driSupport32Bit = true;
		#};
		# Enable GPU acceleration
		raspberry-pi."4".fkms-3d.enable = true;
		# Required for the Wireless firmware
		enableRedistributableFirmware = true;
	};

	powerManagement.cpuFreqGovernor = "ondemand";

	services = {
		dnscrypt-proxy2 = {
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
		xserver = {
			enable = true;
			# Touch input
			#libinput.enable = true;
			# Configure keymap in X11
			layout = "de";
			xkbOptions = "eurosign:e";
			# Enable touchpad support (enabled default in most desktopManager).
			#libinput.enable = true;
			# X uses ... video driver
			#videoDrivers = [ "fbdev" ];
			displayManager.lightdm.enable = true;
		};
		pipewire = {
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
		openssh = {
			enable = true;
			passwordAuthentication = false;
			knownHosts.Cryogonal = {
				hostNames = [ "Cryogonal" "192.168.178.112" ];
				publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcgywMb4yGH8ZN97LBa9P7Q4/3O9GVy/kjtGrV7KFaV";
			};
		};
	};

	# Audio
		# Disable pulseaudio
		hardware.pulseaudio.enable = false;
		# rtkit is optional but recommended
		security.rtkit.enable = true;

	# Networking
	networking = {
		hostName = "Cryogonull";
		nameservers = [ "1.1.1.1" "9.9.9.9" ];
		#resolvconf.enable = false;
		# The global useDHCP flag is deprecated, therefore explicitly set to false here.
		# Per-interface useDHCP will be mandatory in the future, so this generated config
		# replicates the default behaviour.
		useDHCP = false;
		interfaces = {
			eth0.useDHCP = true;
		};
		# If using dhcpcd:
		dhcpcd.extraConfig = "nohook resolv.conf";
		# If using NetworkManager:
		#networkmanager.dns = "none";
		#wireless.enable = true; # Enables wireless support via wpa_supplicant.
		# Configure network proxy if necessary
		#networking.proxy.default = "http://user:password@proxy:port/";
		#networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
		# Firewall
		firewall = {
    			enable = true;
    			allowPing = false;
			allowedTCPPorts = [ 80 443 ];
		};
	};

	systemd.services.dnscrypt-proxy2.serviceConfig = {
		StateDirectory = "dnscrypt-proxy";
	};

	# Set your time zone.
	time.timeZone = "Europe/Berlin";

	console = {
		font = "Lat2-Terminus16";
		keyMap = "de";
	};

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
			wrapperFeatures.gtk = true;
		};
		xwayland.enable = true;
		qt5ct.enable = true;
		#steam.enable = true;
		# Some programs need SUID wrappers, can be configured further or are started in user sessions.
		#mtr.enable = true;
		#gnupg.agent = {
		#	enable = true;
		#	enableSSHSupport = true;
		#};
	};

	i18n = {
		defaultLocale = "en_US.UTF-8";
		extraLocaleSettings = {
			LANGUAGE = "en_US";
			LC_TIME = "de_DE.UTF-8";
			LC_MEASUREMENT = "de_DE.UTF-8";
			LC_ADDRESS = "de_DE.UTF-8";
			LC_PAPER = "de_DE.UTF-8";
			LC_TELEPHONE = "de_DE.UTF-8";
		};
		supportedLocales = [
			"en_US.UTF-8/UTF-8"
			"de_DE.UTF-8/UTF-8"
		];
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
	home-manager.users.papojari = {
		programs = {
			git = {
				enable = true;
				userName = "papojari";
				userEmail = "papojari-git.ovoid@aleeas.com";
			};
		};
	};

	# Automatic upgrades
	system.autoUpgrade = {
		enable = true;
			allowReboot = true;
		channel = "https://nixos.org/channels/nixos-unstable";
		dates = "daily";
	};

	nix = {
		gc = {
			automatic = true;
			dates = "daily";
			options = "--delete-older-than 4d";
		};
		optimise = {
			automatic = true;
			dates = [ "weekly" ];
		};
		# Make ready for nix flakes
		package = pkgs.nixFlakes;
		extraOptions = ''
			experimental-features = nix-command flakes
		'';
	};

	nixpkgs.config = {
		# Allow unfree packages (sorry stallman)
		allowUnfree = true;
		#allowBroken = true;
	};

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		# Languages
		zsh rustc
		# CLI
		cmatrix toilet cowsay wget kakoune htop cava git tealdeer stow youtube-dl ytfzf xplr wpa_supplicant neofetch
		# Video and image
		pqiv mpv
		# Audio
		pavucontrol
		# Wayland, Xorg
		wayland xwayland xorg.xrdb waybar wofi slurp grim swappy alacritty
		# Theming
		papirus-icon-theme lxappearance materia-theme capitaine-cursors
		# Apps
		gnome-passwordsafe gnome.gnome-tweaks spotify-qt mumble #firefox
		# E-Mail
		gnome.geary
		# Media processing
		ffmpeg
		# Development
		cobalt
		# Creative
		gimp inkscape audacity-gtk3
		# Games
		teeworlds
		superTuxKart
		superTux
		#mindustry-wayland
		# Filesystem stuff
		jmtpfs
		gparted dosfstools mtools
		# Printing & scanning
		#cups system-config-printer gnome.simple-scan
	];

	environment.pathsToLink = [ "/libexec" ];

	# Fonts
	fonts.fonts = with pkgs; [
		roboto roboto-mono roboto-mono
		ubuntu_font_family
		font-awesome-ttf
		#nerdfonts
	];

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "21.11"; # Did you read the comment?

}
