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

  # Cachix for wezterm
  nix.settings = {
    substituters = ["https://wezterm.cachix.org"];
    trusted-public-keys = ["wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="];
  };

  system.stateVersion = "24.05";
}
