{ config, lib, pkgs, ... }:

{
  environment.etc = {
    "gtk-2.0/gtkrc".text = ''
      gtk-theme-name=Orchis-Dark
      gtk-icon-theme-name=kora
      gtk-font-name=Inter 10
    '';

    "gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=Orchis-Dark
      gtk-icon-theme-name=kora
      gtk-font-name=Inter 10
    '';
  };
}
