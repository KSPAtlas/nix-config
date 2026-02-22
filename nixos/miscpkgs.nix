{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    curl
    git
    appimage-run
    runapp
  ];

  services.flatpak.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
