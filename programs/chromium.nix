{ config, pkgs, lib, ... }:

{
  programs.chromium = {
    enable = true;
    extraOpts = {
      "BrowserSignin" = 0;
      "SyncDisabled" = false;
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [
        "de"
        "en-US"
      ];
    };
    defaultSearchProviderSearchURL = "https://duckduckgo.com";
    defaultSearchProviderSuggestURL = "https://duckduckgo.com";
    extensions = [
      "gcbommkclmclpchllfjekcdonpmejbdp" # HTTPS Everywhere
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "lckanjgmijmafbedllaakclkaicjfmnk" # ClearURLs
      "ldpochfccmkkmhdbclfhpagapcfdljkj" # Decentraleyes
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "pmcmeagblkinmogikoikkdjiligflglb" # Privacy Redirect
      "fihnjjcciajhdojfnbdddfaoknhalnja" # I don't care about cookies
      "nomnklagbgmgghhjidfhnoelnjfndfpd" # Canvas Blocker - Fingerprint Protect
    ];
  };
}