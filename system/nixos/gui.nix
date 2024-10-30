{ config, lib, pkgs, inputs, ... }:

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
      foot
      wofi
      lxqt.lxqt-policykit
      orchis-theme
      kora-icon-theme
      inputs.zen-browser.packages."${system}".generic
    ];
  };

  programs.regreet.enable = true;
  
  environment.etc."greetd/environments".text = ''
    sway --unsupported-gpu
  '';

  services.gnome.gnome-keyring.enable = true;

  # Sound isn't technically GUI, but if I'm using one I'm using the other
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    jetbrains-mono
    inter
    google-fonts
  ];
}
