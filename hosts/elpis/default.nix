{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../common/users
	../common/global
	../common/desktop/plasma
	../common/desktop/pipewire.nix
	../common/hardware/bluetooth.nix
	../common/hardware/nvidia.nix
	../common/virtualisation
	../common/optional/polkit.nix
	../common/gaming
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "elpis";
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Sao_Paulo";

    system.stateVersion = "23.11";
}

