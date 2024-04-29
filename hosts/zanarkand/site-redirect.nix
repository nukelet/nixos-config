{ pkgs, inputs, lib, config, ... }:

{
    imports = [
        ../common/optional/nginx.nix
    ];

    services.nginx.virtualHosts."www.nukelet.online" = {
        forceSSL = true;
        enableACME = true;
        globalRedirect = "www.nukelet.com";
    };
}
