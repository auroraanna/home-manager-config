{ config, pkgs, lib, ... }:

{
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors-white";
    };
    iconTheme = {
      name = "Adwaita-dark";
      package = pkgs.libadwaita;
    };
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
    font = {
      name = "Inter";
      size = 11;
      package = pkgs.inter;
    };
  };

  xsession.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors-white";
  };
}