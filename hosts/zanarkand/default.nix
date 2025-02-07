{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix

        ../common/users
	../common/global
	../common/virtualisation

	../common/services/headscale.nix
	../common/services/website.nix
	../common/services/syncthing.nix
	
	../common/services/monitoring.nix

	./niones.nix

	../common/services/thelounge.nix

        ./site-redirect.nix
	
	# TODO: move this to https://quartz.jzhao.xyz/
	# ./website-notes.nix

	./synapse.nix
    ];

    networking.hostName = "zanarkand"; # Define your hostname.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    # Avoid annoying timeouts when upgrading the system
    # @nuke: as of 2024-07-27 this breaks NetworkManager
    # (won't start automatically :upside_down:)
    # systemd.services.NetworkManager-wait-online.enable = false;

    # Set your time zone.
    time.timeZone = "America/Sao_Paulo";

    system.stateVersion = "23.11";
}
