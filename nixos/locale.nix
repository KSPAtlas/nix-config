{ config, lib, pkgs, ... }:

{
  time.timeZone = "GB";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "all" ];
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "pl";
    useXkbConfig = true; # use xkb.options in tty.
  };
}
