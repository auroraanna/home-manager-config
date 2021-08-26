{ config, pkgs, lib, ... }:

{
  fonts.fonts = with pkgs; [
    iosevka
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
        sansSerif = [ "Roboto" ];
        monospace = [ "Iosevka" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}