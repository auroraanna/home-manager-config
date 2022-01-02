{ config, pkgs, ... }:

{
  home.file.".config/neofetch/config.conf".source = ./config.conf;
  home.file.".config/neofetch/image.svg".source = builtins.fetchurl {
    url = https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg;
    sha256 = "14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8";
  };
}
