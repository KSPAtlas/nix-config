{
  description = "KSP Atlas' NixOS system as a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };

  outputs = inputs@{ self, nixpkgs, chaotic }:
  let system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;

	config.allowUnfree = true; # Allow using unfree software like NVIDIA drivers or Steam
      };
    in {
      nixosConfigurations = {
        elitism-nix = nixpkgs.lib.nixosSystem {
	  specialArgs = {
	    inherit inputs;
          };

	  modules = [
	    ./nixos/configuration.nix
	    chaotic.nixosModules.default
	  ];
        };
      };
    };
}
