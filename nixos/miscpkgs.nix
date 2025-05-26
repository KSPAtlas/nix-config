{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    curl
    git
    appimage-run
  ];

  services.flatpak.enable = true;
}
