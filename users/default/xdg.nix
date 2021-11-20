{ config, pkgs, ... }:

{
  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = [ "codium.desktop" ];
        "x-scheme-handler/http" = [ "brave-browser.desktop" ];
        "x-scheme-handler/https" = [ "brave-browser.desktop" ];
        "x-scheme-handler/chrome" = [ "brave-browser.desktop" ];
        "x-scheme-handler/about" = [ "brave-browser.desktop" ];
        "x-scheme-handler/unknown" = [ "brave-browser.desktop" ];
        "text/html" = [ "brave-browser.desktop" ];
        "application/x-extension-htm" = [ "brave-browser.desktop" ];
        "application/x-extension-html" = [ "brave-browser.desktop" ];
        "application/x-extension-shtml" = [ "brave-browser.desktop" ];
        "application/xhtml+xml" = [ "brave.desktop" ];
        "application/x-extension-xhtml" = [ "brave-browser.desktop" ];
        "application/x-extension-xht" = [ "brave-browser.desktop" ];
        "image/svg" = [ "brave-browser.desktop" ];
        "image/webp" = [ "org.gnome.gThumb.desktop" ];
        "image/png" = [ "org.gnome.gThumb.desktop" ];
        "image/jpeg" = [ "org.gnome.gThumb.desktop" ];
        "video/mp4" = [ "mpv.desktop" ];
        "video/mkv" = [ "mpv.desktop" ];
        "video/webm" = [ "mpv.desktop" ];
        "audio/mpeg" = [ "mpv.desktop" ];
        "audio/mp4" = [ "mpv.desktop" ];
        "audio/x-wav" = [ "mpv.desktop" ];
        "audio/x-opus+ogg" = [ "mpv.desktop" ];
        "audio/flac" = [ "mpv.desktop" ];
        "application/json" = [ "codium.desktop" ];
        "application/pdf" = [ "brave.desktop;org.gnome.Evince.desktop" ];
      };
    };
  };

  home = {
    packages = with pkgs; [
      xdg-utils
    ];
  };
}
