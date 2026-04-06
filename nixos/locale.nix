{ config, lib, pkgs, ... }:

{
  time.timeZone = "GB";
  i18n.defaultLocale = "pl_PL.UTF-8";
  i18n.supportedLocales = [ "all" ];
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "pl";
    useXkbConfig = true; # use xkb.options in tty.
  };
}
