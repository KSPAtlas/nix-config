{ config, lib, pkgs, ... }:

{
  stylix = {
    enable = true;
    image = ../assets/wallpaper.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/monokai.yaml";
    targets.regreet.enable = true; # Force enable regreet despite not using the official service
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
        name = "Noto Color Emoji";
      };
      sizes.applications = 10;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };
}
