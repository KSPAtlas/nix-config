{ config, lib, pkgs, ... }:

{
  stylix = {
    enable = true;
    image = ../assets/wallpaper.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/monokai.yaml";
    
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
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetbrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 10;
        terminal = 12;
      };
    };

    cursor = {
      package = pkgs.graphite-cursors;
      name = "graphite-dark";
      size = 24;
    };

    icons = {
      enable = true;
      package = pkgs.kora-icon-theme;
      light = "kora";
      dark = "kora";
    };

    polarity = "dark";

    targets.console.enable = false;
  };
}
