# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/430ac30b-4eeb-4be3-b008-82ce2b1eddcb";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/57A8-51EA";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/fd0f7ceb-540f-46bb-88d7-bf0a9abb5431";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/769d79e0-75c2-4a60-8ac5-c8ca1624d2be"; }
    ];


  fileSystems."/run/media/tar/Storage Torrents" = {
    device = "/dev/disk/by-uuid/7376-DC77";
    fsType = "exfat";
    options = ["nofail" "uid=1000" "gid=100" "dmask=007" "fmask=117" "user" "u+rwx" "g+rwx" "o+rwx"];
  };

  # fileSystems."/run/media/tar/Storage-1" = {
  #   device = "/dev/disk/by-uuid/129AAE3D9AAE1CEB";
  #   fsType = "auto";
  #   options = ["nofail" "uid=1000" "gid=100" "dmask=007" "fmask=117" "user" "u+rwx" "g+rwx" "o+rwx"];
  # };

  # fileSystems."/run/media/tar/Storage-2" = {
  #   device = "/dev/disk/by-uuid/6AD23525D234F743";
  #   fsType = "auto";
  #   options = ["nofail" "uid=1000" "gid=100" "dmask=007" "fmask=117" "user" "u+rwx" "g+rwx" "o+rwx"];
  # };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}