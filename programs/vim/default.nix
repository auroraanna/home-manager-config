{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = true;
    withPython3 = true;
    withNodeJs = true;
    configure = {
      customRC = builtins.readFile ./vimrc;
      packages.myVimPackage = with pkgs.vimPlugins; {
        # see examples below how to use custom packages
        start = [ vim-json vim-yaml vim-toml nerdtree vim-nix vim-css-color vim-javascript vim-markdown vim-markdown-toc markdown-preview-nvim vim-surround vim-airline vim-prettier asyncomplete-vim ];
        # If a Vim plugin has a dependency that is not explicitly listed in
        # opt that dependency will always be added to start to avoid confusion.
        opt = [ ];
      };
    };
  };
}