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
        background_opacity = 0.9;
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
          name = "GNOME dark custom";
          # Default colors
          primary = {
            background = "0x06002b";
            foreground = "0xabb2bf";
          };
          normal = {
            black = "0x171421";
            red = "0xc01c28";
            green = "0x26A269";
            yellow = "0xa2734c";
            blue = "0x12488b";
            magenta = "0xa347ba";
            cyan = "0x06989a";
            white = "0xd0cfcc";
          };
          bright = {
            black = "0x5e5c64";
            red = "0xef2929";
            green = "0x8ae234";
            yellow = "0xe9ad0c";
            blue = "0x2a7bde";
            magenta = "0xc061cb";
            cyan = "0x33c7de";
            white = "0xffffff";
          };
        };
      };
    };
  };
}
