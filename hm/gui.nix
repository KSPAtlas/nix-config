{ ... }: {
  programs.noctalia-shell = {
    enable = true;
    settings = {
      general = {
        avatarImage = ../assets/face.png;
        language = "pl";
      };

      bar = {
        widgets = {
          left = [
            {
              id = "Workspace";
            }
            {
              id = "ActiveWindow";
            }
          ];
          center = [
            {
              id = "Clock";
            }
            {
              id = "MediaMini";
            }
          ];
          right = [
            {
              id = "Tray";
            }
            {
              id = "SystemMonitor";
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "Volume";
            }
            {
              id = "ControlCenter";
              useDistroLogo = false;
              icon = "snowflake";
            }
          ];
        };
      };

      location.name = "Edinburgh, Scotland";

      appLauncher = {
        pinnedApps = [
          "zen-twilight.desktop"
          "equibop.desktop"
          "codium.desktop"
          "steam.desktop"
          "foot.desktop" 
        ];

        iconMode = "native";
        terminalCommand = "ghostty -e";

        customLaunchPrefixEnabled = true;
        customLaunchPrefix = "runapp";
      };

      dock.enabled = false;
    };
  };

  stylix.targets.nixcord.enable = false;

  home.file.".config/niri/config.kdl".source = ../dotfiles/niri.kdl;
  gtk.gtk4.theme = null;
}
