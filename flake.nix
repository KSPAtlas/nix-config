{
  description = "KSP Atlas' NixOS system as a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    drawterm.url = "github:KSPAtlas/drawterm-flake";
    nixcord.url = "github:FlameFlag/nixcord";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.quickshell.follows = "quickshell";
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs: let
      pkgs = import nixpkgs {
        hostPlatform.system = "x86_64-linux";
      	config.allowUnfree = true; # Allow using unfree software like NVIDIA drivers or Steam
      };
    in {
      nixosConfigurations = {
        elitism-nix = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };

          modules = [
          #   {
          #     nix.settings = {
          #       substituters = [
          #         "https://cosmic.cachix.org/"
          #         "https://wezterm.cachix.org"
          #       ];
          #       trusted-public-keys = [
          #         "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
          #         "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
          #       ];
          #     };
          #   }
            stylix.nixosModules.stylix
            ./nixos/hardware-configuration.nix
            ./nixos/nvidia.nix
            ./nixos/boot.nix
            ./nixos/nix.nix
            ./nixos/gui.nix
            ./nixos/networking.nix
            ./nixos/locale.nix
            ./nixos/users.nix
            ./nixos/virtualisation.nix
            ./nixos/gaming.nix
            ./nixos/programming.nix
            ./nixos/printer.nix
            ./nixos/miscpkgs.nix
            ./nixos/stylix.nix
            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.ksp = import ./hm/ksp.nix;
                extraSpecialArgs = {
                  inherit inputs;
                };
              };
            }
          ];
        };
      };
    };
}
