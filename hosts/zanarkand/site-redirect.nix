{ pkgs, inputs, lib, config, ... }:

{
    imports = [
        ../common/optional/nginx.nix
    ];

    services.nginx.virtualHosts."www.nukelet.com" = {
        forceSSL = true;
        enableACME = true;
        globalRedirect = "www.nukelet.dev";
    };

    services.nginx.virtualHosts."nukelet.com" = {
        forceSSL = true;
        enableACME = true;
        globalRedirect = "nukelet.dev";
    };
}
