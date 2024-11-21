{
  description = "KSP Atlas' NixOS system as a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    stylix.url = "github:danth/stylix";
    wezterm.url = "github:wez/wezterm?dir=nix";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, chaotic, zen-browser, stylix }:
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
            ./nixos/hardware-configuration.nix
            ./nixos/nvidia.nix
            ./nixos/boot.nix
            ./nixos/nix.nix
            ./nixos/gui.nix
            ./nixos/stylix.nix
            ./nixos/networking.nix
            ./nixos/locale.nix
            ./nixos/users.nix
            ./nixos/virtualisation.nix
            ./nixos/gaming.nix
            ./nixos/programming.nix
            ./nixos/printer.nix
            ./nixos/miscpkgs.nix
            chaotic.nixosModules.default
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.ksp = import ./hm/ksp.nix;
              };
            }
          ];
        };
      };
    };
}
