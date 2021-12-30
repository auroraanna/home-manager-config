{ config, pkgs, fetchurl, ... }:

let
  colorScheme = import ../../../color-schemes/campbell.nix;
  #background = "$HOME/.cache/backgrounds/nix-wallpaper-3d-showcase.png";
  background = "$HOME/.cache/backgrounds/highway-to-shell.png";
  modifier = "Mod4";
  left = "h";
  down = "j";
  up = "k";
  right = "l";
  resizeAmount = "30px";
  menu = "wofi";
  filebrowser = "nemo";
  webbrowser = "brave";
  webbrowserPersistent = "firefox";
  musicplayer = "spotify";
in {
  home = {
    file = {
      ".cache/backgrounds/highway-to-shell.png".source = ../../../backgrounds/highway-to-shell.png;
      #".cache/backgrounds/nix-wallpaper-3d-showcase.png".source = builtins.fetchurl {
      #  url = https://raw.githubusercontent.com/papojari/nixos-artwork/master/wallpapers/nix-wallpaper-3d-showcase-1920x1080.png;
      #  sha256 = "43b0007ad592de52b927713cfea832f80322808cd274422411228e07066db417";
      #};
      ".cache/backgrounds/nix-wallpaper-3d-showcase.png".source = builtins.fetchurl {
        url = https://raw.githubusercontent.com/papojari/nixos-artwork/master/wallpapers/nix-wallpaper-3d-showcase-2560x1440.png;
        sha256 = "14ad3c27d43d23ab672c0455d4501bb2a0e1f26caaae38ac9e2638ed98f7c410";
      };
      #".cache/backgrounds/nix-wallpaper-3d-showcase.png".source = builtins.fetchurl {
      #  url = https://raw.githubusercontent.com/papojari/nixos-artwork/master/wallpapers/nix-wallpaper-3d-showcase-3840x2160.png;
      #  sha256 = "35376f1c95424580c3d3c3f1843b047789be389bff689285bf1948fe36d84779";
      #};
      ".config/sway/idle.sh".source = ./idle.sh;
      ".config/sway/drive-mount.sh".source = ./drive-mount.sh;
      ".config/sway/drive-unmount.sh".source = ./drive-unmount.sh;
      ".config/sway/scan-barcode.sh".source = ./scan-barcode.sh;
      ".config/sway/color-picker.sh".source = ./color-picker.sh;
      ".config/sway/screenshot.sh".source = ./screenshot.sh;
    };
  };
  wayland.windowManager.sway = {
    enable = true;
    config = {
      gaps = {
        smartBorders = "on";
        smartGaps = true;
      };
      floating.border = 1;
      window.border = 1;
      bars = [ ];
      colors = {
        focused = {
          background = colorScheme.green;
          border = colorScheme.greenBright;
          childBorder= colorScheme.green;
          indicator = colorScheme.green;
          text = colorScheme.black;
        };
        focusedInactive = {
          background = colorScheme.yellow;
          border = colorScheme.yellowBright;
          childBorder= colorScheme.yellow;
          indicator = colorScheme.yellow;
          text = colorScheme.black;
        };
        unfocused = {
          background = colorScheme.magenta;
          border = colorScheme.magentaBright;
          childBorder= colorScheme.magenta;
          indicator = colorScheme.magenta;
          text = colorScheme.black;
        };
        urgent = {
          background = colorScheme.red;
          border = colorScheme.redBright;
          childBorder= colorScheme.red;
          indicator = colorScheme.red;
          text = colorScheme.black;
        };
        background = colorScheme.black;
      };
      fonts = {
        names = [ "Roboto" ];
        style = "Regular Bold";
        size = 12.0;
      };
      input = {
        "*" = {
          xkb_layout = "de";
          xkb_variant = "nodeadkeys";
          xkb_options = "grp:alt_shift_toggle";
          xkb_numlock = "enable";
        };
      };
      menu = menu;
      modifier = modifier;
      left = left;
      down = down;
      up = up;
      right = right;
      keybindings = {
        # Exit sway (logs you out of your Wayland session)
        "${modifier}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
        # Reload the configuration file
        "${modifier}+Shift+r" = "reload";
        # Kill focused window
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec ${menu}";
        # Launch the default terminal. $TERM is defined in ../alacritty.nix line 11
        "${modifier}+x" = "exec kitty";
        # Take a screenshot by selecting an area
        "print" = "exec sh $HOME/.config/sway/screenshot.sh";
        # Scan a barcode on the screen
        "pause" = "exec sh $HOME/.config/sway/scan-barcode.sh";
        "${modifier}+f7" = "exec ${filebrowser}";
        "${modifier}+f8" = "exec ${webbrowser}";
        "${modifier}+f9" = "exec ${webbrowserPersistent}";
        "${modifier}+f10" = "exec ${musicplayer}";
        # Toggle deafen
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        # Toggle mute
        "XF86AudioMute+Ctrl" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle && ffmpeg -y -f lavfi -i 'sine=frequency=200:duration=0.1' /tmp/sound.ogg && play /tmp/sound.ogg";
        # Raise sink (speaker, headphones) volume
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +2%";
        # Lower sink (microphone) volume
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -2%";
        # Spotify
        ## Play/pause spotify
        "XF86AudioPlay" = "exec dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause";
        ## Play previous spotify track
        "XF86AudioPrev" = "exec dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous";
        "XF86Launch5" = "exec dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous";
        ## Play next spotify track
        "XF86AudioNext" = "exec dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next";
        "XF86Tools" = "exec dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next";
        # Moving around
        ## Move your focus around
        "${modifier}+${left}" = "focus left";
        "${modifier}+${down}" = "focus down";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${right}" = "focus right";
        ### With arrow keys
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";
        ## Move the focused window with the same, but add Shift
        "${modifier}+Shift+${left}" = "focus left";
        "${modifier}+Shift+${down}" = "focus down";
        "${modifier}+Shift+${up}" = "focus up";
        "${modifier}+Shift+${right}" = "focus right";
        ### With arrow keys
        "${modifier}+Shift+Left" = "focus left";
        "${modifier}+Shift+Down" = "focus down";
        "${modifier}+Shift+Up" = "focus up";
        "${modifier}+Shift+Right" = "focus right";
        # Workspaces
        ## Switch to workspace
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";
        ## Move focused container to workspace
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";
        ## Workspaces can have any name you want, not just numbers.
        ## We just use 1-10 as the default.
        # Layout stuff
        ## You can "split" the current object of your focus with ${modifier}+b, ${modifier}+v for horizontal and vertical splits respectively.
        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";
        ## Switch the current container between different layout styles
        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";
        ## Make the current focus fullscreen
        "${modifier}+f" = "fullscreen";
        ## Toggle the current focus between tiling and floating mode
        "${modifier}+Shift+space" = "floating toggle";
        ## Swap focus between the tiling area and the floating area
        "${modifier}+space" = "focus mode_toggle";
        ## Move focus to the parent container
        "${modifier}+a" = "focus parent";
        # Scratchpad
        ## Sway has a "scratchpad", which is a bag of holding for windows. You can send windows there and get them back later.
        ## Move the currently focused window to the scratchpad
        "${modifier}+Shift+minus" = "move scratchpad";
        ## Show the next scratchpad window or hide the focused scratchpad window. If there are multiple scratchpad windows, this command cycles through them.
        "${modifier}+minus" = "scratchpad show";
        # Resizing containers
        # Mode "resize"
        "${modifier}+r" = "mode 'resize'";
      };
      modes = {
        rezise = {
          # left will shrink the containers width
          # right will grow the containers width
          # up will shrink the containers height
          # down will grow the containers height
          "${modifier}+${left}" = "resize shrink width ${resizeAmount}";
          "${modifier}+${down}" = "resize grow height ${resizeAmount}";
          "${modifier}+${up}" = "resize shrink height ${resizeAmount}";
          "${modifier}+${right}" = "resize grow width ${resizeAmount}";
          ## With arrow keys
          "${modifier}+Left" = "resize shrink width ${resizeAmount}";
          "${modifier}+Down" = "resize grow height ${resizeAmount}";
          "${modifier}+Up" = "resize shrink height ${resizeAmount}";
          "${modifier}+Right" = "resize grow width ${resizeAmount}";
          # Return to default mode
          "Return" = "mode 'default'";
          "Escape" = "mode 'default'";
        };
      };
      startup = [
        # Status bar: waybar
        { command = "waybar"; }
        # Notification daemon
        { command = "mako"; }
        # Polkit
        { command = "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1"; }
        # Idle
        { command = "$HOME/.config/sway/idle.sh"; }
      ];
      terminal = pkgs.alacritty;
      window.titlebar = false;
      workspaceAutoBackAndForth = true;
      output = {
        "*" = { bg = "${background} fit #000000"; };
        # You can get the names of your outputs by running: swaymsg -t get_outputs
        DVI-I-1 = {
          resolution = "1920x1080";
          position = "320,0";
        };
        DP-1 = {
          resolution = "2560x1440";
          position = "0,1080";
        };
        HDMI-A-1 = {
          resolution = "1920x1080";
          position = "2560,952";
          transform = "90";
        };
      };
      #focus = "DP-1";
    };
  };
  home.packages = with pkgs; [
    waybar ulauncher wofi wofi-emoji slurp grim swappy swaylock-fancy notify-desktop mako libappindicator gnome.zenity
  ];
}
