{ pkgs, inputs, lib, config, ... }:

{
    imports = [ ../common/optional/nginx.nix ];
    # other Nginx options
    services.nginx.virtualHosts."niones.wiki" =  {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
            proxyPass = "http://127.0.0.1:8081";
            proxyWebsockets = true; # needed if you need to use WebSocket
                extraConfig =
                # required when the target is also TLS server with multiple hosts
                "proxy_ssl_server_name on;" +
                # required when the server wants to use HTTP Authentication
                "proxy_pass_header Authorization;"
                ;
        };
    };
}
