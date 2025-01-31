# https://nixos.org/manual/nixos/stable/index.html#module-services-matrix-synapse
{ inputs, lib, config, pkgs, ... }:

let
    domain = "${config.networking.domain}";
    fqdn = "matrix.${domain}";
    baseUrl = "https://${fqdn}";
    clientConfig."m.homeserver".base_url = baseUrl;
    serverConfig."m.server" = "${fqdn}:443";
    mkWellKnown = data: ''
      default_type application/json;
      add_header Access-Control-Allow-Origin *;
      return 200 '${builtins.toJSON data}';
    '';
in {
    imports = [ ../common/optional/nginx.nix ];

    services.postgresql.enable = true;
    services.matrix-synapse = {
        enable = true;
        enableRegistrationScript = true;
        configureRedisLocally = true;
        settings = {
            server_name = "${domain}";
            public_baseurl = "${baseUrl}";
            enable_registration = false;
            # for adding new users with matrix-synapse-register-new-matrix-user
            # registration_shared_secret = "aaaaaaaaaaaaaaaa";
        };

        settings.listeners = [
            {
                bind_addresses = ["127.0.0.1"];
                port = 8008;
                resources = [
                    {
                        compress = true;
                        names = ["client" "federation"];
                    }
                ];
                tls = false;
                type = "http";
                x_forwarded = true;
            }
        ];
    };

    services.nginx.virtualHosts.${domain} = {
        forceSSL = true;
        enableACME = true;
        locations."= /.well-known/matrix/server".extraConfig = mkWellKnown serverConfig;
        locations."= /.well-known/matrix/client".extraConfig = mkWellKnown clientConfig;
    };

    services.nginx.virtualHosts.${fqdn} = {
        forceSSL = true;
        enableACME = true;
        # It's also possible to do a redirect here or something else, this vhost is not
        # needed for Matrix. It's recommended though to *not put* element
        # here, see also the section about Element.
        locations."/".extraConfig = ''
          return 404;
        '';
        # Forward all Matrix API calls to the synapse Matrix homeserver. A trailing slash
        # *must not* be used here.
        locations."/_matrix".proxyPass = "http://127.0.0.1:8008";
        # Forward requests for e.g. SSO and password-resets.
        locations."/_synapse/client".proxyPass = "http://127.0.0.1:8008";
    };
}
