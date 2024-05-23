{ inputs, lib, config, ... }:

{
    imports = [ ../optional/nginx.nix ];

    services.prometheus.exporters = {
        node = {
            enable = true;
            enabledCollectors = [ "systemd" ];
            port = 9002;
        };
    };

    services.cadvisor = {
        enable = true;
        port = 9003;
        services.cadvisor.listenAddress = "0.0.0.0";
    };

    networking.firewall.interfaces = {
        "tailscale0" = {
            allowedTCPPorts = [ 9002 9003 ];
        };
    };
}
