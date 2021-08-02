{ config, pkgs, ... }:

{
  home.file = {
    ".config/wofi/config".text = ''
      show=drun
      prompt=search
      insensitive=true
      allow_images=true
      image_size=16
    '';
    ".config/wofi/style.css".source = ./style.css;
  };
}
