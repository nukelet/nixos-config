{ pkgs, inputs, lib, config, ... }:

let
    baseDomain = config.networking.domain;
    subDomain = "www";
    fullDomain = "${subDomain}.${baseDomain}";
in {
    imports = [ ./nginx.nix ];
    services.nginx.virtualHosts.${fullDomain} = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
            root = inputs.website;
        };
    };
}
