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
  };

  # Cachix for wezterm
  # nix.settings = {
  #   substituters = [
  #     "https://cosmic.cachix.org/"
  #   ];
  #   trusted-public-keys = [
  #     "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
  #   ];
  # };

  programs.nix-ld.enable = true;

  system.stateVersion = "24.05";
}
