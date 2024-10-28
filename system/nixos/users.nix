{ config, lib, pkgs, ... }:

{
  users.users.ksp = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.nushell;
  };

  security.polkit.enable = true;
}
