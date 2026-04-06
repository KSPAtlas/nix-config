{ config, lib, pkgs, inputs, ... }:

{
  programs.regreet.enable = true;

  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages."${stdenv.hostPlatform.system}".twilight
    inputs.drawterm.packages."${stdenv.hostPlatform.system}".default
    wezterm

    inputs.noctalia.packages."${stdenv.hostPlatform.system}".default
    quickshell
    xwayland-satellite
    nautilus # Needed for file picker
    graphite-cursors
  ];

  # Niri
  programs.niri.enable = true;

  qt = {
    enable = true;
    style = "breeze";
  };

  services.gvfs.enable = true;

  # Sound isn't technically GUI, but if I'm using one I'm using the other
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  stylix.targets.qt.enable = false;
  stylix.targets.chromium.enable = false;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    fira-code
    fira-code-symbols
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    inter
    google-fonts
  ];
}
