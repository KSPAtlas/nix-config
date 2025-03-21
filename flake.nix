{
  description = "KSP Atlas' NixOS system as a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.follows = "nixos-cosmic/nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    wezterm.url = "github:wez/wezterm?dir=nix";
    drawterm.url = "github:KSPAtlas/drawterm-flake";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
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
            {
              nix.settings = {
                substituters = [
                  "https://cosmic.cachix.org/"
                  "https://wezterm.cachix.org"
                ];
                trusted-public-keys = [
                  "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
                  "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
                ];
              };
            }
            ./nixos/hardware-configuration.nix
            ./nixos/nvidia.nix
            ./nixos/boot.nix
            ./nixos/nix.nix
            ./nixos/gui.nix
            # ./nixos/stylix.nix
            ./nixos/networking.nix
            ./nixos/locale.nix
            ./nixos/users.nix
            ./nixos/virtualisation.nix
            ./nixos/gaming.nix
            ./nixos/programming.nix
            ./nixos/printer.nix
            ./nixos/miscpkgs.nix
            ./nixos/gpupassthrough.nix
            inputs.chaotic.nixosModules.default
            inputs.nixos-cosmic.nixosModules.default
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
