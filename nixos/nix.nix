{ inputs, pkgs, lib, config, ... }:
{
  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    persistent = true;
    dates = "weekly";
    automatic = true;
  };

  system.stateVersion = "24.05";
}
