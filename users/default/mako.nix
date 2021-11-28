{ config, pkgs, ... }:

{
  programs = {
    mako = {
      enable = true;
      defaultTimeout = 2000;
      margin = "20";
      padding = "10";
      anchor = "bottom-right";
      backgroundColor = "#F1F3F5FF";
      borderColor = "#E8E8E8FF";
      borderRadius = 10;
      borderSize = 0;
      textColor = "#343546ff";
      font = "Roboto 10";
    };
  };
}
