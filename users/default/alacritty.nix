{ config, pkgs, fontSize, ... }:

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        live_config_reload = true;
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
          size = 15;
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
          name = "Campbell extended";
          # Default colors
          primary = {
            background = "0x0c0c0c";
            foreground = "0xf2f2f2";
          };
          normal = {
            black = "0x0c0c0c";
            red = "0xc50f1f";
            green = "0x13a10e";
            yellow = "0xc19c00";
            blue = "0x0037da";
            magenta = "0x881798";
            cyan = "0x3a96dd";
            white = "0xcccccc";
          };
          bright = {
            black = "0x767676";
            red = "0xe74856";
            green = "0x16c60c";
            yellow = "0xf9f1a5";
            blue = "0x3b78ff";
            magenta = "0xb4009e";
            cyan = "0x61d6d6";
            white = "0xf2f2f2";
          };
        };
      };
    };
  };
}
