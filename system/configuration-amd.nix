# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
	imports = [
			# Include the results of the hardware scan.
			./hardware-configuration.nix
		];

	boot = {
		loader = {
			systemd-boot = {
				enable = true;
				configurationLimit = 8;
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

	hardware = {
		# Microcode
		cpu.amd.updateMicrocode = true;
		# OpenGL & Vulkan
		opengl = {
			driSupport = true;
			driSupport32Bit = true;
			extraPackages = with pkgs; [
				rocm-opencl-icd
				rocm-opencl-runtime
				amdvlk
			];
			# For 32 bit applications
			# Only available on unstable
			extraPackages32 = with pkgs; [
				driversi686Linux.amdvlk
			];
		};
		# Disable Pulseaudio because Pipewire is used
		pulseaudio.enable = false;
		sane = {
			enable = true;
			extraBackends = [ pkgs.hplipWithPlugin ];
		};
	};

	# Networking
	networking = {
		hostName = "Cryogonal";
		nameservers = [
			"1.1.1.1"
			"9.9.9.9"
		];
		#resolvconf.enable = false;
		# The global useDHCP flag is deprecated, therefore explicitly set to false here.
		# Per-interface useDHCP will be mandatory in the future, so this generated config
		# replicates the default behaviour.
		useDHCP = false;
		interfaces.enp34s0.useDHCP = true;
		# If using dhcpcd:
		dhcpcd.extraConfig = "nohook resolv.conf";
		# If using NetworkManager:
		#networkmanager.dns = "none";
		#wireless.enable = true;	# Enables wireless support via wpa_supplicant.
		# Configure network proxy if necessary
		#networking.proxy.default = "http://user:password@proxy:port/";
		#networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
		# Firewall
		firewall = {
			# Steam
			allowedTCPPorts = [
				80 443 27036
			];
			allowedUDPPorts = [
				4380 3478 4379 4380
			];
			allowedUDPPortRanges = [
				{
					from = 27000;
				to = 27100;
				}
			];
			allowedTCPPortRanges = [
				{
					from = 27015;
					to = 27030;
				}
			];
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

	services = {
		fstrim.enable = true;
		dbus.apparmor = "enabled";
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
		gvfs = {
			enable = true;
		};
		xserver = {
			enable = true;
			# Configure keymap in X11
			layout = "de";
			xkbOptions = "eurosign:e";
			# Enable touchpad support (enabled default in most desktopManager).
			#libinput.enable = true;
			# X uses amdgpu video driver
			videoDrivers = [
				"amdgpu"
			];
			displayManager = {
				gdm = {
					enable = true;
					wayland = true;
				};
			};
			desktopManager = {
	    			gnome.enable = true;
			};
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
					matches = [
						{
							"device.name" = "~bluez_card.*";
						}
					];
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
						{
							"node.name" = "~bluez_input.*";
						}
						# Matches all outputs
						{
							"node.name" = "~bluez_output.*";
						}
					];
					actions = {
						"node.pause-on-idle" = false;
					};
				}
			];
		};
		printing = {
			# Enable CUPS to print documents.
			enable = true;
			# Driver
			drivers = with pkgs; [
				hplipWithPlugin
			];
		};
	};

	security = {
		# rtkit is optional but recommended
		rtkit.enable = true;
		apparmor = {
			enable = true;
			packages = with pkgs; [
				apparmor-profiles
			];
		};
	};

	# Mounting
	fileSystems = {
		"/backgrounds" = {
			device = "/dev/disk/by-uuid/9feb2ea8-a1c5-4dc7-866e-402437d2489f";
			fsType = "btrfs";
			options = [ "subvolid=329" ];
		};
		"/games/ssd-btrfs" = {
			device = "/dev/disk/by-uuid/9feb2ea8-a1c5-4dc7-866e-402437d2489f";
			fsType = "btrfs";
			options = [ "subvolid=331" ];
		};
		"/git-repos" = {
			device = "/dev/disk/by-uuid/9feb2ea8-a1c5-4dc7-866e-402437d2489f";
			fsType = "btrfs";
			options = [ "subvolid=1007" ];
		};
		"/data" = {
			device = "/dev/disk/by-uuid/9feb2ea8-a1c5-4dc7-866e-402437d2489f";
			fsType = "btrfs";
			options = [ "subvolid=356" ];
		};
		"/stick" = {
			device = "/dev/disk/by-uuid/9feb2ea8-a1c5-4dc7-866e-402437d2489f";
			fsType = "btrfs";
			options = [ "subvolid=436" ];
		};
		"/video-download" = {
			device = "/dev/disk/by-uuid/2b2f4aec-9d14-450e-93c4-b5f7d8dafafa";
			fsType = "btrfs";
			options = [ "subvolid=336" ];
		};
		"/images" = {
			device = "/dev/disk/by-uuid/2b2f4aec-9d14-450e-93c4-b5f7d8dafafa";
			fsType = "btrfs";
			options = [ "subvolid=335" ];
		};
		"/ginkgo" = {
			device = "/dev/disk/by-uuid/2b2f4aec-9d14-450e-93c4-b5f7d8dafafa";
			fsType = "btrfs";
			options = [ "subvolid=354" ];
		};
		"/games/hdd-btrfs" = {
			device = "/dev/disk/by-uuid/2b2f4aec-9d14-450e-93c4-b5f7d8dafafa";
			fsType = "btrfs";
			options = [ "subvolid=328" ];
		};
		"/games/hdd-ntfs" = {
			device = "/dev/disk/by-uuid/5C2CF7652CF7389A";
			fsType = "ntfs";
		};
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
		java.enable = true;
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
		steam.enable = true;
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
	users.users = {
		papojari = {
			isNormalUser = true;
			home = "/home/papojari";
			description = "papojari";
			extraGroups = [
				"wheel"
				"networkmanager"
				"video"
				"lp"
			];
			shell = pkgs.zsh;
			openssh.authorizedKeys.keys = [
				"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcgywMb4yGH8ZN97LBa9P7Q4/3O9GVy/kjtGrV7KFaV papojari@Cryogonal"
			];
		};
	};

	# Automatic upgrades
	system.autoUpgrade ={
		enable = true;
		channel = "https://nixos.org/channels/nixos-unstable";
		dates = "daily";
	};

	nixpkgs.config = {
		# Allow unfree packages (sorry stallman)
		allowUnfree = true;
		allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      		"hplip"
    		];
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

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment = {
		variables = {
			CLICOLOR = "TRUE";
			EDITOR = "codium";
			TERM = "xterm-256color";
		};
		shellAliases = {
			ll = "ls -al";
			l="ls -lFh";
			la = "ls -a";
			lr = "ls -tRFh";
			lt = "ls -ltFh";
			ldot = "ls -ld .*";
			lS = "ls -1FSsh";
			lart = "ls -1Fcart";
			lrt = "ls -1Fcrt";
			grep = "grep --color=auto";
			dud = "du -d 1 -h";
			duf = "du -sh *";
			help = "man";
		};
		pathsToLink = [ "/libexec" ];
		systemPackages = with pkgs; [
			# Languages
			zsh rustc
			# CLI
			tmux cmatrix toilet cowsay wget kakoune neofetch htop cava git git-crypt gnupg pinentry-gnome tealdeer stow unzip pandoc youtube-dl ytfzf librespeed-cli lolcat bpytop freshfetch radeontop wkhtmltopdf sftpman
			# Video and image
			pqiv mpv scrcpy
			# Audio
			pipewire pavucontrol pulseaudio
			# Wayland, Xorg
			wayland xwayland xorg.xrdb polkit polkit_gnome waybar wofi slurp grim swappy rofi mako libappindicator
			# Theming
			papirus-icon-theme lxappearance materia-theme capitaine-cursors pywal
			# Other
			gnome.gnome-tweak-tool gnome.gnome-shell-extensions
			# File browsers
			gnome.nautilus cinnamon.nemo xplr
			# Web browsers
			firefox-wayland
			# Music streaming
			spotify
			# E-Mail
			gnome.geary
			# Password managers
			bitwarden
			# Office
			libreoffice-fresh
			# Vulkan
			vulkan-loader mangohud vulkan-tools
			# MTP
			jmtpfs
			# Filesystem stuff
			gparted dosfstools mtools ntfs3g btrfs-progs sshfs
			# Printing & scanning
			cups system-config-printer gnome.simple-scan
			# Python packages
			python39Packages.pyqt5
		];
	};

	# Fonts
	fonts.fonts = with pkgs; [
		roboto roboto-mono roboto-mono
		ubuntu_font_family
		font-awesome-ttf
		nerdfonts
	];

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "21.11"; # Did you read the comment?

}