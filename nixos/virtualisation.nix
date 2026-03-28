{ config, lib, pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = [ pkgs.virtiofsd ];
  };
  programs.virt-manager.enable = true;
  networking.firewall.trustedInterfaces = [ "virbr0" ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  environment.systemPackages = with pkgs; [
    distrobox
    nvidia-container-toolkit
  ];

  environment.etc = {
    "libvirt/network.conf".text = ''
      firewall_backend = "iptables"
    '';
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
