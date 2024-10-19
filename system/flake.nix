{
  description = "KSP Atlas' NixOS system as a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = inputs@{ self, nixpkgs, chaotic, zen-browser }:
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
