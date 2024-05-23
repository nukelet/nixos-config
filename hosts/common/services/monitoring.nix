{ inputs, lib, config, ... }:

let
    baseDomain = config.networking.domain;
    subDomain = "grafana";
    fullDomain = "${subDomain}.${baseDomain}";
in {
    imports = [ ../optional/nginx.nix ];

    services.grafana = {
        enable = true;
        settings.server = {
            domain = "${fullDomain}";
            http_addr = "127.0.0.1";
            http_port = 8000;
        };
    };

    services.prometheus = {
        enable = true;
        port = 8001;
        scrapeConfigs = [
            {
                job_name = "zanarkand";
                static_configs = [{
                    targets = [
                        "127.0.0.1:8001"
                        "127.0.0.1:8002"
                        "127.0.0.1:8003"
                    ];
                }];
            }

            {
                job_name = "thavnair";
                static_configs = [{
                    targets = [
                        "thavnair:8002"
                        "thavnair:8003"
                    ];
                }];
            }
        ];
    };

    services.prometheus.exporters = {
        node = {
            enable = true;
            enabledCollectors = [ "systemd" ];
            listenAddress = "127.0.0.1";
            port = 8002;
        };
    };

    services.cadvisor = {
        enable = true;
        port = 8003;
        listenAddress = "127.0.0.1";
    };

    services.nginx.virtualHosts.${fullDomain} = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
            proxyPass = "http://${toString config.services.grafana.settings.server.http_addr}:${toString config.services.grafana.settings.server.http_port}";
            proxyWebsockets = true;
            recommendedProxySettings = true;
        };
    };
}
