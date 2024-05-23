{ inputs, lib, config, ... }:

let
    baseDomain = config.networking.domain;
    subDomain = "grafana";
    fullDomain = "${subDomain}.${baseDomain}";
in {
    imports = [ ../optional/nginx.nix ];

    services.grafana = {
        forceSSL = true;
        enableACME = true;
        enable = true;
        domain = "${fullDomain}";
        port = 9000;
        addr = "127.0.0.1";
    };

    services.prometheus = {
        enable = true;
        port = 9001;
    };

    services.nginx.virtualHosts.${fullDomain} = {
        locations."/" = {
            proxyPass = "http://127.0.0.1:${config.services.grafana.port}";
            proxyWebsockets = true;
        };
    };
}
