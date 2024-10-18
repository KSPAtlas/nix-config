{ config, lib, pkgs, ... }:

{
  environment.etc = {
    "xdg/gtk-2.0/gtkrc".text = ''
      gtk-theme-name = "Orchis-Dark"
    '';

    "xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name = "Orchis-Dark"
    '';
  };
}
