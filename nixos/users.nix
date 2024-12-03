{ config, lib, pkgs, ... }:

{
  users.users.ksp = {
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.nushell;
  };

  security.polkit.enable = true;
}
