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
    };
}
