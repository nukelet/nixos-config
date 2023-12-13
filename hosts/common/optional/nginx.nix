{ inputs, lib, config, ... }:

{
    services.nginx.enable = true;
    security.acme = {
        acceptTerms = true;
        defaults.email = "nukelet64@gmail.com";
        server = "https://acme-staging-v02.api.letsencrypt.org/directory";
    };
}
