{ config, pkgs, ... }:

{
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

  programs.fish.enable = true;
  programs.fish.functions = {
  	nxos-fbld.body = ''
		cd ~/dotfiles
		git add .
		git commit -m 'nix update'
		sudo nixos-rebuild switch --flake ~/dotfiles
	'';

	hmgr-fbld.body = "home-manager switch --flake ~/dotfiles/home-manager";

	nxsh.body = ''
		argparse c/cmd -- $argv
		or return

		if set -ql _flag_cmd
			nix-shell -p $argv[1] --run $argv[2]
		else
			nix-shell -p $argv[1] --run $argv[1]
		end
	'';
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
    floorp
    thunderbird
    vesktop
    ripgrep
    fd
    emacs
    btop
    libreoffice-qt6
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "kora";
      package = pkgs.kora-icon-theme;
    };
    theme = {
      name = "Orchis-Dark";
      package = pkgs.orchis-theme;
    };
    font = {
      name = "Inter";
      package = pkgs.inter;
    };
  };

  home.file.".icons/default".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic"; 

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
    ".config/fastfetch/config.jsonc".source = dotfiles/fastfetch.jsonc;
    ".config/sway/config".source = dotfiles/sway_config;
    ".config/sway/wallpaper.jpg".source = dotfiles/wallpaper.jpg;
    ".config/wofi/style.css".source = dotfiles/wofi.css;
    ".config/foot/foot.ini".source = dotfiles/foot.ini;
    ".config/foot/theme.ini".source = "${builtins.fetchGit {
        url = "https://github.com/tinted-theming/base16-foot";
	rev = "1547efe73638522fe41253d439467757f32a2fb5";
    }}/colors/base16-monokai.ini";
  };

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