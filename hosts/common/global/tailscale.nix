{ inputs, lib, config, pkgs, ... }:

{
    services.tailscale.enable = true;
    networking.firewall = {
        checkReversePath = "loose";
        trustedInterfaces = [ "tailscale0" ];
        allowedUDPPorts = [ config.services.tailscale.port ];
    };
    environment.systemPackages = [ pkgs.tailscale ];
}
