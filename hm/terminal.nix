{ pkgs, lib, ... }: {

  programs = {
      nushell = {
        enable = true;
        configFile.source = ../dotfiles/config.nu;
        envFile.source = ../dotfiles/env.nu;
      };
      carapace.enable = true;
      carapace.enableNushellIntegration = true;
      zoxide.enable = true;
      zoxide.enableNushellIntegration = true;
      starship.enable = true;
      starship.enableNushellIntegration = true;
      starship.settings = {
        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
        };
      };
    
      bat = {
        enable = true;
        syntaxes.nushell = {
          src = pkgs.fetchFromGitHub {
            owner = "kurokirasama";
            repo = "nushell_sublime_syntax";
            rev = "8a1bb9205859d0c2f362c6c5a2b7ef1a7a87c387";
            hash = "sha256-2A7c6/FOsOyzyGAshZJZvZ/m5w1cKj7uckB+pzdlr3M=";
          };
          file = "nushell.sublime-syntax";
        };
      };
    
      direnv = {
        enable = true;
        enableNushellIntegration = true;
        nix-direnv.enable = true;
        config = {
          warn_timeout = "0s";
          hide_env_diff = true;
        };
      };

      fastfetch = {
        enable = true;
        settings = {
          logo = {
            type = "kitty";
            source = ../assets/nixlogo.png;
            height = 27;
          };
          modules = [
            "title"
            "separator"
            "os"
            "host"
            "kernel"
            "uptime"
            "packages"
            "shell"
            "display"
            "de"
            "wm"
            "wmtheme"
            "theme"
            "icons"
            "font"
            "cursor"
            "terminal"
            "terminalfont"
            "cpu"
            "gpu"
            "memory"
            "swap"
            "disk"
            "localip"
            "battery"
            "poweradapter"
            "locale"
            "break"
            "colors"
          ];
        };
      };
    };

    
  # programs.foot = {
  #   enable = true;
  #   settings = {
  #     main = {
  #       shell = "nu";
  #       pad = "10x10";
  #     };
  #     csd.preferred = "none";
  #   };
  # };

  programs.ghostty = {
    enable = true;
    systemd.enable = true;
    settings = {
      window-padding-x = 8;
      window-padding-y = 8;
    };
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    btop
    vivid
    unzip
    chafa
  ];
}
