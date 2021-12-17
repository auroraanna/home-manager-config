{ config, pkgs, lib, ... }:

{
  fonts.fonts = with pkgs; [
    iosevka
    inter
    roboto
    noto-fonts-emoji
    font-awesome
  ];

  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        serif = [ "Roboto Slab" ];
        sansSerif = [ "Inter" ];
        monospace = [ "Iosevka" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}