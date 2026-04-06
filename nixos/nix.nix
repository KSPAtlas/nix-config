{ inputs, pkgs, lib, config, ... }:
{
  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];


  nix.settings.auto-optimise-store = true;

  nix.gc = {
    persistent = true;
    dates = "weekly";
    automatic = true;
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "24.05";
}
