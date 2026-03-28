{ config, lib, pkgs, ... }:

{
  networking.hostName = "elitism-nix";
  networking.networkmanager.enable = true;
  # programs.wireshark.enable = true;
  # services.avahi = {
  #   enable = true;
  #   publish.userServices = true;
  # };

  # services.sunshine = {
  #   enable = true;
  #   openFirewall = true;
  # };
  
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
}
