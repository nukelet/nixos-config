{ config, lib, pkgs, modulesPath, ... }:

{
    boot.kernelPackages = pkgs.linuxPackages_latest;
    imports =
        [ (modulesPath + "/installer/scan/not-detected.nix")
        ];
    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems = {
        "/" = {
            label = "system";
            fsType = "btrfs";
            options = [
                "subvol=root"
                "defaults"
                "lazytime"
                "noatime"
                "compress=zstd"
                "autodefrag"
                # TODO: implement an fstrim timer later
                "nodiscard"
            ];
        };

        "/nix" = {
            label = "system";
            fsType = "btrfs";
            options = [
                "subvol=nix"
                "defaults"
                "lazytime"
                "noatime"
                "compress=zstd"
                "autodefrag"
                # TODO: implement an fstrim timer later
                "nodiscard"
            ];
        };

        "/boot" =
        { device = "/dev/disk/by-uuid/9CF2-0401";
            fsType = "vfat";
        };
    };

    swapDevices = [ ];

# Enables DHCP on each ethernet and wireless interface. In case of scripted networking
# (the default) this is the recommended approach. When using systemd-networkd it's
# still possible to use this option, but it's recommended to use it in conjunction
# with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
# networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
