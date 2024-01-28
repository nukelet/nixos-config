{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../common/users
	../common/global
	../common/virtualisation
	../common/optional/headscale.nix
	../common/optional/quassel.nix
	../common/optional/website.nix
    ];

    networking.hostName = "zanarkand"; # Define your hostname.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

    # Set your time zone.
    time.timeZone = "America/Sao_Paulo";

    system.stateVersion = "23.11";
}
