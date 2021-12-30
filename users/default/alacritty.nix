{ config, pkgs, fontSize, ... }:

let
  colorScheme = import ../../color-schemes/campbell.nix;
in {
  programs = {
    alacritty = {
      enable = true;
      settings = {
        live_config_reload = true;
        env.TERM = "alacritty";
        shell.program = "${pkgs.zsh}/bin/zsh";
        selection.save_to_clipboard = true;
        url = {
          launcher = "open";
          modifiers = "shift";
        };
        mouse_bindings = [
          {
            mouse = "Middle";
            action = "PasteSelection";
          }
        ];
        key_bindings = [
          {
            key = "N";
            mods = "Control|Shift";
            action = "SpawnNewInstance";
          }
          {
            key = "Q";
            mods = "Control";
            action = "Quit";
          }
          {
            key = "V";
            mods = "Control|Shift";
            action = "Paste";
          }
          {
            key = "C";
            mods = "Control|Shift";
            action = "Copy";
          }
          {
            key = "NumpadAdd";
            mods = "Control";
            action = "IncreaseFontSize";
          }
          {
            key = "NumpadSubtract";
            mods = "Control";
            action = "DecreaseFontSize";
          }
          {
            key = "Key0";
            mods = "Control";
            action = "ResetFontSize";
          }
        ];
        background_opacity = 1;
        bell = {
          animation = "EaseOutExpo";
          duration = 5;
          color = "#ffffff";
        };
        cursor = {
          style = "Block";
          unfocused_hollow = true;
        };
        font = {
          use_thin_strokes = true;
          offset = {
            x = 0;
            y = 0;
          };
          glyph_offset = {
            x = 0;
            y = 0;
          };
          size = 13;
          normal = {
            family = "Iosevka";
            style = "Medium";
          };
          bold = {
            family = "Iosevka";
            style = "Bold";
          };
          italic = {
            family = "Iosevka";
            style = "Italic";
          };
        };
        window = {
          decorations = "full";
          padding = {
            x = 5;
            y = 5;
          };
        };
        draw_bold_text_with_bright_colors = true;
        colors = {
          name = colorScheme.name;
          primary = {
            background = colorScheme.black;
            foreground = colorScheme.white;
          };
          normal = {
            black = colorScheme.black;
            red = colorScheme.red;
            green = colorScheme.green;
            yellow = colorScheme.yellow;
            blue = colorScheme.blue;
            magenta = colorScheme.magenta;
            cyan = colorScheme.cyan;
            white = colorScheme.white;
          };
          bright = {
            black = colorScheme.blackBright;
            red = colorScheme.redBright;
            green = colorScheme.greenBright;
            yellow = colorScheme.yellowBright;
            blue = colorScheme.blueBright;
            magenta = colorScheme.magentaBright;
            cyan = colorScheme.cyanBright;
            white = colorScheme.whiteBright;
          };
        };
      };
    };
  };
}
