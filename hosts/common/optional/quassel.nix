{ config, pkgs, ... }:

{
    networking.firewall.allowedTCPPorts = [ 4242 ];
    services.quassel = {
        enable = true;
        interfaces = [ "0.0.0.0" ];
    };
}
