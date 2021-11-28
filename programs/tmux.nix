{ config, pkgs, lib, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    clock24 = true;
    extraConfig = builtins.readFile (
      builtins.fetchurl {
        url = https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf;
        sha256 = "0ww8cyx1k4zdrjhx6x2i0byg8c4drqnj4i05i7fm0crkllkf1c8z";
      }
    );
    extraTmuxConf = builtins.readFile (
      builtins.fetchurl {
        url = https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf.local;
        sha256 = "1d3523gjj4xxfchvj9mbkzymblw5xgly74f0k56sjrqcbknl3ln3";
      }
    );
  };
}