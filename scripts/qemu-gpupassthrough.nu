#!/usr/bin/env nu

let passthrough_guests = [ 'bazzite' ]
let display_manager = 'greetd'
let pci_devices = [
  'pci_0000_01_00_0' # GPU
  'pci_0000_01_00_1' # HDMI audio
]

def main [
  guest_name: string
  hook_name: string
  state_name: string
  ...misc: string
] {
  if $guest_name in $passthrough_guests {
    if $hook_name == 'prepare' and $state_name == 'begin' {
      # Stop the display manager, we don't want it
      systemctl stop $display_manager

      # Unbind the vtconsoles
      print 0 o> /sys/class/vtconsole/vtcon0/bind
      print 0 o> /sys/class/vtconsole/vtcon1/bind

      # Unbind the EFI framebuffer
      print 'efi-framebuffer.0' o> /sys/bus/platform/drivers/efi-framebuffer/unbind

      # Unload NVIDIA drivers
      modprobe -r nvidia_drm nvidia_modeset nvidia_uvm nvidia

      # Detach PCI devices
      $pci_devices | each {|dev|
        virsh nodedev-detach $dev
      }

      # Load VFIO
      modprobe vfio-pci
    } else if $hook_name == 'release' and $state_name == 'end' {
      # Reattach PCI devices to host
      $pci_devices | each {|dev|
        virsh nodedev-reattach $dev
      }

      # Unload VFIO
      modprobe -r vfio-pci

      # Rebind EFI framebuffer
      print 'efi-framebuffer.0' o> /sys/bus/platform/drivers/efi-framebuffer/bind

      # Reload NVIDIA drivers
      [ 'nvidia_drm' 'nvidia_modeset' 'nvidia_uvm' 'nvidia' ] | each {|mod|
        modprobe $mod
      }

      # Rebind the vtconsoles
      print 1 o> /sys/class/vtconsole/vtcon0/bind
      print 1 o> /sys/class/vtconsole/vtcon1/bind

      # Restart display manager
      systemctl start $display_manager
    }
  }
}
