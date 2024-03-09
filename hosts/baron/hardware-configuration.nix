{ config, lib, pkgs, modulesPath, ... }:

{
    imports =
        [ (modulesPath + "/installer/scan/not-detected.nix")
        ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
    { device = "/dev/disk/by-uuid/49afd068-a10d-46e5-9c6c-39f70f12363e";
        fsType = "btrfs";
        options = [
            "defaults"
            "lazytime"
            "noatime"
            "compress=zstd"
            "autodefrag"
            # TODO: implement an fstrim timer later
            "nodiscard"
        ];
    };

    fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/523B-64C8";
        fsType = "vfat";
    };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
