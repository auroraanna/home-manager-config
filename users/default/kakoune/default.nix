{ config, pkgs, ... }:

{
  programs.kakoune = {
    enable = true;
    extraConfig = builtins.readFile ./copy_to_system_clipboard.kak;
    config = {
      colorScheme = "gruvbox-dark";
      wrapLines = {
        enable = true;
        indent = true;
        marker = "⏎";
        word = true;
      };
      numberLines.enable = true;
      showWhitespace.enable = true;
    };
    plugins = with pkgs.kakounePlugins; [
      kak-lsp tabs-kak pandoc-kak kakoune-rainbow
    ];
  };
}
