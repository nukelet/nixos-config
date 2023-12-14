{ inputs, lib, config, ... }:

let
    baseDomain = config.networking.domain;
    subDomain = "headscale";
    fullDomain = "${subDomain}.${baseDomain}";
in {
    imports = [ ./nginx.nix ];
    services.headscale = {
        enable = true;
        address = "0.0.0.0";
        port = 8080;
        settings = {
            logtail.enabled = false;
            server_url = "https://${fullDomain}";
            dns_config.base_domain = baseDomain;
        };
    };

    services.nginx.virtualHosts.${fullDomain} = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
            proxyPass = "http://localhost:${toString config.services.headscale.port}";
            proxyWebsockets = true;
        };
    };

    environment.systemPackages = [ config.services.headscale.package ];
}
