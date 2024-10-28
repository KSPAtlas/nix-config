{ config, lib, pkgs, ... }:

{
  networking.hostName = "elitism-nix";
  networking.networkmanager.enable = true;
  programs.wireshark.enable = true;
}
