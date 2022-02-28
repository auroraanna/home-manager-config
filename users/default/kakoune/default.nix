{ config, pkgs, ... }:

{
  home.file.".config/kak/copy_to_system_clipboard.kak".source = ./copy_to_system_clipboard.kak;
  home.file.".config/kak/disable_auto_indent.kak".source = ./disable_auto_indent.kak;

  programs.kakoune = {
    enable = true;
    extraConfig = builtins.readFile ./sources.kak;
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
