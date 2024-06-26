# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
    imports =
        [ (modulesPath + "/installer/scan/not-detected.nix")
        ];

    boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];

    fileSystems."/" =
    { device = "/dev/disk/by-uuid/7db36e69-77ea-4e9b-8d37-d4433a92dfb6";
        fsType = "btrfs";
        options = [ "subvol=root" "compress=zstd" "noatime" ];
    };

    fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/7db36e69-77ea-4e9b-8d37-d4433a92dfb6";
        fsType = "btrfs";
        options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

    fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/7db36e69-77ea-4e9b-8d37-d4433a92dfb6";
        fsType = "btrfs";
        options = [ "subvol=log" "compress=zstd" "noatime" ];
    };

    fileSystems."/home" =
    { device = "/dev/disk/by-uuid/c398f562-08d3-4fd0-a109-2e0afa321c16";
        fsType = "btrfs";
        options = [ "subvol=home" "compress=zstd" "noatime" ];
    };

    fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/7db36e69-77ea-4e9b-8d37-d4433a92dfb6";
        fsType = "btrfs";
        options = [ "subvol=persist" "compress=zstd" "noatime" ];
    };

    fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F8D7-F70A";
        fsType = "vfat";
    };

    swapDevices =
        [ { device = "/dev/disk/by-uuid/7e368bc8-7b66-4b44-a9d8-5d129fb1cb66"; }
        ];

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
