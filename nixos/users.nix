{ config, lib, pkgs, ... }:

{
  users.users.ksp = {
    description = "KSP Atlas";
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" "kvm" "libvirtd" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.nushell;
  };

  security.polkit.enable = true;
}
