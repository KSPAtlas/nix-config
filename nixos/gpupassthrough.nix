{ config, lib, pkgs, ... }:

{
  boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
  ];

  virtualisation.libvirtd.hooks = {
    qemu."gpupassthrough" = ../scripts/qemu-gpupassthrough.nu;
  };
}
