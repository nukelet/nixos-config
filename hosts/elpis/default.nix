{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix

        # machine-specific audio patches
        # TODO: fix this (using `environment.etc."<pipewireconf>"` is no longer supported)
        ./audio

        ./vpn

        ../common/users
	../common/global

	../common/hardware/bluetooth.nix
	../common/hardware/nvidia.nix
	# ../common/hardware/nouveau.nix

	../common/desktop/pipewire.nix

	../common/desktop/i3
	# ../common/desktop/sway

	../common/virtualisation
	../common/virtualisation/qemu.nix

	../common/optional/polkit.nix
	../common/optional/keyring.nix

	../common/gaming
	../common/gaming/sunshine.nix

	../common/optional/wireshark.nix
    ];

    environment.systemPackages = with pkgs; [ obs-studio ];

    # for some stupid reason NixOS defaults to LMB+RMB = middle button click
    services.xserver.libinput.mouse.middleEmulation = false;

    # for nvidia proprietary drivers in sway
    programs.sway.extraOptions = [ "--unsupported-gpu" ];

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

