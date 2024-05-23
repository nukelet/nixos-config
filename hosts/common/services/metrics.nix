{ inputs, lib, config, ... }:

{
    imports = [ ../optional/nginx.nix ];

    services.prometheus.exporters = {
        node = {
            enable = true;
            enabledCollectors = [ "systemd" ];
            port = 8002;
        };
    };

    services.cadvisor = {
        enable = true;
        port = 8003;
        listenAddress = "0.0.0.0";
    };

    networking.firewall.interfaces = {
        "tailscale0" = {
            allowedTCPPorts = [ 8002 8003 ];
        };
    };
}
