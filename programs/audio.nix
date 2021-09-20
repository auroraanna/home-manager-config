{ config, pkgs, lib, ... }:

{
  hardware = {
    # Disable Pulseaudio because Pipewire is used
    pulseaudio.enable = false;
  };

	environment.systemPackages = with pkgs; [
		pavucontrol pulseaudio
	];

	services = {
    pipewire = {
      enable = true;
      # Support alsa programs
      alsa.enable = true;
      alsa.support32Bit = true;
      # Support pulseaudio programs
      pulse.enable = true;
      # Support JACK programs
      #jack.enable = true;
      # Bluetooth
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
  };
}