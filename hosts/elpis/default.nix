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

    # TODO: maybe refactor this into something more idiomatic?
    #       and maybe move it to home-manager somehow?
    services.xserver.displayManager.setupCommands = ''
        LEFT='HDMI-0'
        RIGHT='DP-0'
        ${pkgs.xorg.xrandr}/bin/xrandr --output $RIGHT --primary --output $RIGHT --left-of DP-0
    '';

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "elpis";
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Sao_Paulo";

    system.stateVersion = "23.11";
}

