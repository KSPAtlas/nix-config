{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    curl
    git
  ];
}
