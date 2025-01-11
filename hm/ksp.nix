{ pkgs, lib, ... }:

{

  nixpkgs.config.allowUnfree = true;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ksp";
  home.homeDirectory = "/home/ksp";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs = {
    nushell = {
      enable = true;
      configFile.source = dotfiles/config.nu;
      envFile.source = dotfiles/env.nu;
    };
    carapace.enable = true;
    carapace.enableNushellIntegration = true;
    zoxide.enable = true;
    zoxide.enableNushellIntegration = true;
    # starship.enable = true;

    direnv = {
      enable = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };

    fastfetch = {
      enable = true;
      settings = {
        logo = {
          type = "iterm";
          source = ../assets/nixlogo.png;
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

    helix = {
      enable = true;
      themes = {
        monokai-plus = {
          inherits = "monokai";
          type = {
            modifiers = ["italic"];
            fg = "type";
          };
          comment = {
            modifiers = ["italic"];
            fg = "#88846F";
          };

          "type.builtin" = {
            modifiers = ["italic"];
            fg = "#66D9EF";
          };

          "variable.parameter" = {
            modifiers = ["italic"];
            fg = "#FD971F";
          };
        };
      };
      settings = {
        theme = lib.mkForce "monokai-plus";

        editor.cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        keys.insert = {          
          up = "no_op";
          down = "no_op";
          left = "no_op";
          right = "no_op";
          pageup = "no_op";
          pagedown = "no_op";
          home = "no_op";
          end = "no_op";
        };
      };

      languages = {
        language = [
          {
            name = "nix";
            language-servers = [ "nixd" "nil" ];
          }
          {
            name = "scheme";
            language-servers = [ "scheme-langserver" ];
          }
        ];

        language-server = {
          nixd.command = "nixd";
          scheme-langserver.command = "scheme-langserver";
        };
      }; 
    };
  };


  # wayland.windowManager.sway = {
  #   enable = true;
  #   config = {
  #     modifier = "Mod4";
  #     terminal = "foot";

  #   };
  # };
  
  gtk.iconTheme = {
    name = "kora";
    package = pkgs.kora-icon-theme;
  };

  qt = {
    enable = true;
    style.name = "adwaita-dark";
  };
  
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    fastfetch
    lagrange
    thunderbird
    vesktop
    ripgrep
    fd
    btop
    libreoffice-qt6
    vivid
    unzip
    libsixel
    xfce.thunar
    xfce.thunar-archive-plugin
    qbittorrent
    imv

    zls
    nixd
    akkuPackages.scheme-langserver
    python312Packages.python-lsp-server
    haskell-language-server
    ghc

    python312Full
    zig
    lutris
    wineWowPackages.stable
  ];

  # gtk = {
  #   enable = true;
  #   iconTheme = {
  #     name = "kora";
  #     package = pkgs.kora-icon-theme;
  #   };
  #   theme = {
  #     name = "Orchis-Dark";
  #     package = pkgs.orchis-theme;
  #   };
  #   font = {
  #     name = "Inter";
  #     package = pkgs.inter;
  #   };
  # };

  # home.file.".icons/default".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic"; 

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/sway/config".source = dotfiles/sway_config;
    ".config/sway/wallpaper.jpg".source = ../assets/wallpaper.jpg;
    ".config/wofi/style.css".source = dotfiles/wofi.css;
    # ".config/foot/foot.ini".source = dotfiles/foot.ini;
    # ".config/foot/theme.ini".source = "${builtins.fetchGit {
    #     url = "https://github.com/tinted-theming/tinted-foot";
    #     rev = "e558fe47e187093313f19fa6a9eea61940ffbd6b";
    # }}/colors/base16-monokai.ini";
    ".config/nushell/theme.nu".source = "${pkgs.nu_scripts}/share/nu_scripts/themes/nu-themes/monokai.nu";
    ".wezterm.lua".source = dotfiles/wezterm.lua;
  };

  # Yes, an entire derivation for terminfo
  home.file.".terminfo".source = let wezterm-terminfo = pkgs.stdenv.mkDerivation {
    name = "wezterm-terminfo";
    src = pkgs.fetchFromGitHub {
      owner = "wez";
      repo = "wezterm";
      rev = "4050072da21cc3106d0985281d75978c07e22abc";
      hash = "sha256-8lv1bc7Lw5S7UFOduShwSHfBzB4Vl0ex22Cb+q/qLi0=";
    };

    buildInputs = [ pkgs.ncurses ];
    buildPhase = "tic -x -o terminfo termwiz/data/wezterm.terminfo";
    installPhase = "cp -r terminfo $out/";
  }; in "${wezterm-terminfo}";

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ksp/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    GRIM_DEFAULT_DIR = /home/ksp/Pictures/Grim;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
