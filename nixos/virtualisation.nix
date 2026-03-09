{ config, lib, pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  networking.firewall.trustedInterfaces = [ "virbr0" ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  environment.systemPackages = with pkgs; [
    distrobox
  ];

  environment.etc = {
    "libvirt/network.conf".text = ''
      firewall_backend = "iptables"
    '';
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
