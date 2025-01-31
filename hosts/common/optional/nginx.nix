{ inputs, lib, config, ... }:

{
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    services.nginx = {
        enable = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
    };
    security.acme = {
        acceptTerms = true;
        defaults.email = "nukelet64@gmail.com";
        # to avoid getting ratelimited when testing stuff...
        defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
    };
}
