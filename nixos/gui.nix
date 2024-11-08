{ config, lib, pkgs, inputs, ... }:

# let
#  greetdConfig = pkgs.writeText "greetd-sway-config" ''
#     exec ${config.programs.regreet.package}/bin/regreet; swaymsg exit
#     assign [all] output HDMI-A-1
#     '';
# in 
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    package = inputs.chaotic.packages.${pkgs.system}.sway_git;
    extraPackages = with pkgs; [
      grim
      slurp
      wl-clipboard
      mako
      kitty
      wofi
      lxqt.lxqt-policykit
      orchis-theme
      kora-icon-theme
      inputs.zen-browser.packages."${system}".generic
    ];
  };

  # programs.foot = {
  #   enable = true;
  # };
  
  programs.regreet = {
    enable = true;
    cageArgs = [
      "-s"
      "-m"
      "last"
    ];
    theme = lib.mkForce {
      package = pkgs.orchis-theme;
      name = "Orchis-Dark";
    };
    iconTheme = {
      package = pkgs.kora-icon-theme;
      name = "kora";
    };
    font.size = 12;
    settings = {
      background.fit = "Fill";
      appearance.greeting_msg = "Nixing my OS";
    };
  };
  
  services.greetd.settings.default_session.command = let
    leftmonitor = "DP-1";
    rightmonitor = "HDMI-A-1";
    runcommand = "sh -c \"${lib.getExe pkgs.wlr-randr} --output ${rightmonitor} --on --output ${leftmonitor} --off; exec ${lib.getExe config.programs.regreet.package}\"";
  in ''
    ${pkgs.dbus}/bin/dbus-run-session ${lib.getExe pkgs.cage} ${lib.escapeShellArgs config.programs.regreet.cageArgs} -- ${runcommand}
  '';  
  # services.greetd.settings.default_session.command = "${inputs.chaotic.packages.${pkgs.system}.sway_git}/bin/sway --unsupported-gpu --config ${greetdConfig}";
   
  # environment.etc."greetd/environments".text = ''
  #   sway --unsupported-gpu
  # '';

  services.xserver.displayManager.session = [
    {
      manage = "desktop";
      name = "sway-nvidia";
      start = "sway --unsupported-gpu";
    }
  ];

  services.gnome.gnome-keyring.enable = true;

  # Sound isn't technically GUI, but if I'm using one I'm using the other
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    jetbrains-mono
    inter
    google-fonts
  ];
}
