{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../common/users
	../common/global
	../common/desktop/plasma
	../common/desktop/bluetooth.nix
	../common/desktop/pipewire.nix
	../common/optional/polkit.nix
	../common/gaming
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "amaurot";
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Sao_Paulo";

    virtualisation.docker.enable = true;

    system.stateVersion = "23.11";
}

