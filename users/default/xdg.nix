{ config, pkgs, ... }:

{
  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = [ "codium.desktop" ];
        "x-scheme-handler/http" = [ "brave.desktop" ];
        "x-scheme-handler/https" = [ "brave.desktop" ];
        "image/webp" = [ "org.gnome.gThumb.desktop" ];
        "image/png" = [ "org.gnome.gThumb.desktop" ];
        "image/jpeg" = [ "org.gnome.gThumb.desktop" ];
        "video/mp4" = [ "org.gnome.Totem.desktop;mpv.desktop" ];
        "video/webm" = [ "org.gnome.Totem.desktop;mpv.desktop" ];
        "audio/mpeg" = [ "org.gnome.Totem.desktop;mpv.desktop" ];
        "audio/mp4" = [ "org.gnome.Totem.desktop;mpv.desktop" ];
        "audio/x-wav" = [ "org.gnome.Totem.desktop;mpv.desktop" ];
        "audio/x-opus+ogg" = [ "org.gnome.Totem.desktop;mpv.desktop" ];
        "audio/flac" = [ "org.gnome.Totem.desktop;mpv.desktop" ];
        "application/json" = [ "codium.desktop" ];
        "application/pdf" = [ "brave-browser.desktop;org.gnome.Evince.desktop" ];
      };
    };
  };
}
