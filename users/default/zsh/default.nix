{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    history.path = "$HOME/.cache/zsh_history";
    #initExtra = ''
    #  eval "$(zoxide init zsh)"
    #'';
  };
}
