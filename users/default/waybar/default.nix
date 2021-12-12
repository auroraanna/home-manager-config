{ config, pkgs, lib, ... }:

let
  colorScheme = import ../../../color-schemes/prism.nix;
  scratchpadIndicatorScript = builtins.fetchurl {
    url = https://raw.githubusercontent.com/justinesmithies/sway-dotfiles/master/.local/bin/statusbar/scratchpad-indicator.sh;
    sha256 = "0xv2w1512gv31sbnwd1grdhrcvzngn8ljdj3x61mqgcqfcp57mwz";
  };
in {
  home.packages = with pkgs; [
    jq
  ];

  home.file = {
    ".config/waybar/style.css".source = ./style.css;
  };
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top"; # Waybar at top layer
        position = "top"; # Waybar position (top|bottom|left|right)
        height = 32; # Waybar height
        # "width" = 48; # Waybar width
        # Choose the order of the modules
        modules-left = [ "custom/power" "sway/mode" "custom/drive-mount" "custom/drive-unmount" "custom/media" "custom/screenshot" "custom/scan-barcode" "custom/color-picker" "pulseaudio" "backlight" "custom/emoji-picker" ];
        modules-center = [ "sway/workspaces" "sway/window" "custom/scratchpad-indicator" "tray" ];
        modules-right = [ "battery" "battery#bat2" "cpu" "memory" "custom/gpu" "disk" "temperature" "network" "clock" ];
          modules = {
          "sway/workspaces" = {
            disable-scroll = true;
            disable-markup  = false;
            all-outputs = false;
            format = "  {icon}  ";
            #format ="{icon}";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
              "10" = "10";
              "focused" = "";
              "default" = "";
            };
          };
          "sway/mode" = {
            format = "<span style=\"italic\">{}</span>";
          };
          "sway/language" = {
            format = "{}";
            max-length = 50;
          };
          "idle_inhibitor" = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };
          "tray" = {
            icon-size = 21;
            spacing = 10;
          };
          "clock" = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y/%m/%d} ";
            format = "{:%H:%M} ";
          };
          "cpu" = {
            format = "{usage}%  CPU";
          };
          "memory" = {
            format = "{}% ";
          };
          "disk" = {
            format = "{}% ";
            tooltip-format = "{used} / {total} used";
          };
          "temperature" = {
            # thermal-zone = 2;
            "hwmon-path" = "/sys/class/hwmon/hwmon1/temp1_input";
            critical-threshold = 80;
            # format-critical = "{temperatureC}°C ";
            format = "{temperatureC}°C ";
          };
          "backlight" = {
            # device = "acpi_video1";
            format = "{percent}% {icon}";
            states = [ "0" "50" ];
          };
          "battery" = {
            states = {
              good = 95;
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            # "format-good" = ""; # An empty format will hide the module
            # "format-full" = "";
            format-icons = [ "" "" "" "" "" ];
          };
          "battery#bat2" = {
            "bat" = "BAT2";
          };
          "network" = {
            # "interface" = "wlp2s0"; # (Optional) To force the use of this interface
            "format-wifi" = "{essid} ({signalStrength}%) ";
            "format-ethernet" = "{ifname} = {ipaddr}/{cidr} ";
            "format-disconnected" = "Disconnected ⚠";
            "interval" = 7;
          };
          "bluetooth" = {
            format = "<b>{icon}</b>";
            format-alt = "{status} {icon}";
            interval = 30;
            format-icons = {
              "enabled" = "";
              "disabled" = "";
            };
            tooltip-format = "{}";
          };
          "pulseaudio" = {
            #"scroll-step" = 1;
            "format" = "{volume}% {icon}";
            "format-bluetooth" = "{volume}% {icon}";
            "format-muted" = "";
            "format-icons" = {
              "headphones" = "";
              "handsfree" = "";
              "headset" = "";
              "phone" = "";
              "portable" = "";
              "car" = "";
              "default" = ["" ""];
            };
            "on-click" = "pavucontrol";
          };
          "custom/media" = {
            "format" = "{icon} {}";
            "return-type" = "json";
            "max-length" = 40;
            "format-icons" = {
              "spotify" = "";
              "default" = "🎜";
            };
            "escape" = true;
            "exec" = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
          };
          "custom/power" = {
            format = "";
            on-click = "swaynag --border-bottom-size=3 --message-padding=8 --button-border-size=5 --button-padding=8 --background=${colorScheme.yellow} --border-bottom=${colorScheme.yellowDarker} --button-border=${colorScheme.greyLight} --button-background=${colorScheme.white} -f Roboto -t warning -m 'Power Menu Options' -b '⏻︁ Power off'  'shutdown -P now' -b '↻︁ Restart' 'shutdown -r now' -b '🛌︁ Hibernate' 'systemctl hibernate' -b '🛌︁ Hybrid-sleep' 'systemctl hybrid-sleep' -b '🛌︁ Suspend' 'systemctl suspend' -b '︁ Logout' 'swaymsg exit' -b ' Lock' 'swaylock-fancy -f Roboto'";
            #on-click = "sh $HOME/.config/waybar/power-menu.sh";
          };
          "custom/gpu" = {
            # Use either the next line or the second and third next line
            "exec" = "command -v radeontop >/dev/null 2>&1 && radeontop -d - -l 1 | tr -d '\n' | cut -s -d ',' -f3 | cut -s -d ' ' -f3 | tr -d '%' | awk '{ print $1 }' | tr -d '\n' || echo 'No radeontop'";
            #"exec" = "radeontop -d - -l 1 | tr -d '\n' | cut -s -d ',' -f3 | cut -s -d ' ' -f3 | tr -d '%' | awk '{ print $1 }' | tr -d '\n'";
            #"exec-if" = "command -v radeontop";
            "format" = "{}%  GPU";
            "interval" = 10;
          };
          "custom/screenshot" = {
            "format" = " ";
            "tooltip-format" = "Take a screenshot";
            "on-click" = "sh $HOME/.config/sway/screenshot.sh";
          };
          "custom/scan-barcode" = {
            "format" = "";
            "tooltip-format" = "Scan a barcode on the screen(s)";
            "on-click" = "sh $HOME/.config/sway/scan-barcode.sh";
          };
          "custom/color-picker" = {
            "format" = "";
            "tooltip-format" = "Pick a color on the screen(s)";
            "on-click" = "sh $HOME/.config/sway/color-picker.sh";
          };
          "custom/drive-mount" = {
            "format" = "";
            "tooltip" = "true";
            "tooltip-format" = "Mount /dev/sde1";
            "on-click" = "sh $HOME/.config/sway/drive-mount.sh";
          };
          "custom/drive-unmount" = {
            "format" = "";
            "tooltip" = "true";
            "tooltip-format" = "Unmount /dev/sde1";
            "on-click" = "sh $HOME/.config/sway/drive-unmount.sh";
          };
          "custom/emoji-picker" = {
            "format" = "👾";
            "tooltip" = "true";
            "tooltip-format" = "Pick an emoji and copy it to the clipboard";
            "on-click" = "wofi-emoji";
          };
          "custom/scratchpad-indicator" = {
            "format-text" = "{}";
            "return-type" = "json";
            "interval" = 2;
            "exec" = "sh ${scratchpadIndicatorScript} 2> /dev/null";
            "exec-if" = "exit 0";
            "on-click"= "swaymsg 'scratchpad show'";
            "on-click-right" = "swaymsg 'move scratchpad'";
          };
        };
      }
    ];
  };
}