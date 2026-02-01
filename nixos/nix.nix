{ inputs, pkgs, lib, config, ... }:
{
  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.package = pkgs.lixPackageSets.latest.lix;

  nix.settings.auto-optimise-store = true;

  nix.gc = {
    persistent = true;
    dates = "weekly";
    automatic = true;
    options = "--delete-older-than 7d";
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

  nix.settings = {
    trusted-public-keys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" # haskell.nix
    ];
    substituters = [
      "https://cache.iog.io"
    ];
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libunwind
      libcxx
    ];
  };

  system.stateVersion = "24.05";
}
