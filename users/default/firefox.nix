{ config, pkgs, lib, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles.default = {
      isDefault = true;
      name = "default";
      settings = {
        "browser.startup.homepage" = https://papojari.codeberg.page;
        "browser.search.isUS" = false;
        "general.useragent.locale" = "en-US";
        "browser.bookmarks.showMobileBookmarks" = true;
      };
      extraConfig = ''
        user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
        user_pref("svg.context-properties.content.enabled", true);
      '';
    };
  };
  home.file.".mozilla/firefox/default/chrome".source = builtins.fetchurl {
    url = https://github.com/muckSponge/MaterialFox/tree/master/chrome;
    sha256 = "1pqp3g67v0qs2xq6r9qjn8n6f7m3h2m29riq5bh72gvyr4sj2rh8";
  };
}
