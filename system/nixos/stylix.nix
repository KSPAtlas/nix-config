{ config, lib, pkgs, ... }:

{
  stylix = {
    enable = true;
    image = ../assets/wallpaper.jpg;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/monokai.yaml";
    fonts = {
      serif = {
        package = pkgs.quattrocento;
        name = "Quattrocento";
      };

      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      monospace = {
        package = pkgs.jetbrains-mono;
        name = "Jetbrains Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji"
      };
    };

    cursor = {
      package = pkgs.bibata-cursor;
      name = "Bibata-Modern-Classic";
    }
  };
}
