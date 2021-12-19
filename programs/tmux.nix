{ config, pkgs, lib, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    clock24 = true;
    extraConfig = builtins.readFile (
      builtins.fetchurl {
        url = https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf;
        sha256 = "1s3j13wkxn79g29lbw8lf3rl5a1bawdj1vyf06bnfgsr0gc37jdl";
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