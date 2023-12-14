{ inputs, lib, config, ... }:

{
    services.networking.firewall.allowedTCPPorts = [ 80 443 ];
    services.nginx.enable = true;
    security.acme = {
        acceptTerms = true;
        defaults.email = "nukelet64@gmail.com";
        defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
    };
}
