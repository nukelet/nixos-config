{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../common/users
	../common/global
    ];


    # Use the GRUB 2 boot loader.
    boot.loader.grub.enable = true;
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.efiInstallAsRemovable = true;
    # boot.loader.efi.efiSysMountPoint = "/boot/efi";
    # Define on which hard drive you want to install Grub.
    boot.loader.grub.device = "nodev"; # or "nodev" for efi only

    networking.hostName = "thavnair"; # Define your hostname.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

    # Set your time zone.
    time.timeZone = "America/Sao_Paulo";

    virtualisation.docker.enable = true;

    system.stateVersion = "23.11";

}

