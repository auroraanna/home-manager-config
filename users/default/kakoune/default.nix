{ config, pkgs, ... }:

{
  home.file.".config/kak/smarttab.kak".source = builtins.fetchurl {
    url = https://raw.githubusercontent.com/andreyorst/smarttab.kak/master/rc/smarttab.kak;
    sha256 = "1xqljpv4jy7c42yh4h4xp8r3j3k0xn20yagi0dscdv2gpgqgsjn3";
  };
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
