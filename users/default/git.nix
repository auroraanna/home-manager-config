{ config, pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      signing = { signByDefault = true; };
      lfs.enable = true;
      delta.enable = true;
      extraConfig = {
        init.defaultBranch = "main";
        tag.gpgSign = true;
        core.editor = "flatpak run --file-forwarding re.sonny.Commit @@";
      };
    };
  };

  home.packages = with pkgs; [ github-desktop ];
}
