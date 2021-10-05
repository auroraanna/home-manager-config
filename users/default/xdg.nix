{ config, pkgs, ... }:

{
  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = [ "codium.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "x-scheme-handler/chrome" = [ "firefox.desktop" ];
        "text/html" = [ "firefox.desktop" ];
        "application/x-extension-htm" = [ "firefox.desktop" ];
        "application/x-extension-html" = [ "firefox.desktop" ];
        "application/x-extension-shtml" = [ "firefox.desktop" ];
        "application/xhtml+xml" = [ "firefox.desktop" ];
        "application/x-extension-xhtml" = [ "firefox.desktop" ];
        "application/x-extension-xht" = [ "firefox.desktop" ];
        "image/svg" = [ "brave-browser.desktop" ];
        "image/webp" = [ "org.gnome.gThumb.desktop" ];
        "image/png" = [ "org.gnome.gThumb.desktop" ];
        "image/jpeg" = [ "org.gnome.gThumb.desktop" ];
        "video/mp4" = [ "mpv.desktop" ];
        "video/webm" = [ "mpv.desktop" ];
        "audio/mpeg" = [ "mpv.desktop" ];
        "audio/mp4" = [ "mpv.desktop" ];
        "audio/x-wav" = [ "mpv.desktop" ];
        "audio/x-opus+ogg" = [ "mpv.desktop" ];
        "audio/flac" = [ "mpv.desktop" ];
        "application/json" = [ "codium.desktop" ];
        "application/pdf" = [ "firefox.desktop;org.gnome.Evince.desktop" ];
      };
    };
  };

  home = {
    packages = with pkgs; [
      xdg-utils
    ];
  };
}
