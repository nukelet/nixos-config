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
	./website-notes.nix
    ];

    networking.hostName = "zanarkand"; # Define your hostname.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    # Avoid annoying timeouts when upgrading the system
    systemd.services.NetworkManager-wait-online.enable = false;

    # Set your time zone.
    time.timeZone = "America/Sao_Paulo";

    system.stateVersion = "23.11";
}
