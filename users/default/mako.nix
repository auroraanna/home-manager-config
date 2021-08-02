{ config, pkgs, ... }:

{
  programs = {
    mako = {
      enable = true;
      defaultTimeout = 8000;
      anchor = "bottom-right";
      backgroundColor = "#FFFFFFFF";
      borderColor = "#E8E8E8FF";
      borderRadius = 10;
      borderSize = 0;
      textColor = "#000000";
      font = "Roboto 15";
    };
  };
}
