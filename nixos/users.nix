{ config, lib, pkgs, ... }:

{
  users.users.ksp = {
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" "kvm" "libvirt" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.nushell;
  };

  security.polkit.enable = true;
}
