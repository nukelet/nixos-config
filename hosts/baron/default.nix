{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        # ./network.nix
        ../common/users
	../common/global
	../common/virtualisation
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "baron"; # Define your hostname.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

    # Set your time zone.
    time.timeZone = "America/Sao_Paulo";

    system.stateVersion = "23.11";
}

