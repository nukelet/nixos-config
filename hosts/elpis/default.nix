{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix

        # machine-specific audio patches
        ./audio

        ../common/users
	../common/global

	../common/hardware/bluetooth.nix
	../common/hardware/nvidia.nix
	../common/desktop/pipewire.nix

	../common/desktop/i3

	../common/virtualisation
	../common/virtualisation/qemu.nix

	../common/optional/polkit.nix
	../common/gaming

	../common/optional/wireshark.nix
    ];

    environment.systemPackages = [ pkgs.obs-studio ];

    # for some stupid reason NixOS defaults to LMB+RMB = middle button click
    services.xserver.libinput.mouse.middleEmulation = false;

    # configure monitors in xrandr
    # TODO: maybe refactor this into something more idiomatic?
    #       and maybe move it to home-manager somehow?
    # services.xserver.displayManager.setupCommands = ''
    #     LEFT='HDMI-0'
    #     RIGHT='DP-0'
    #     ${pkgs.xorg.xrandr}/bin/xrandr --auto && ${pkgs.xorg.xrandr}/bin/xrandr --output $RIGHT --primary --output $LEFT --left-of $RIGHT
    # '';

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "elpis";
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Sao_Paulo";

    system.stateVersion = "23.11";
}

