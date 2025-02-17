{ config, lib, pkgs, ... }:

{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.configurationLimit = 8;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
    ];
  };
}
