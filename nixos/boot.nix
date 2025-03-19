{ config, lib, pkgs, ... }:

{
  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 0;
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 8;
      edk2-uefi-shell.enable = true;
      memtest86.enable = true;
      netbootxyz.enable = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
    ];
  };
}
