{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../common/users
	../common/global
	# ../common/desktop/plasma
	../common/desktop/sway
	../common/desktop/pipewire.nix
	../common/hardware/bluetooth.nix
	../common/hardware/amd.nix
	../common/virtualisation
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

    system.stateVersion = "23.11";
}

