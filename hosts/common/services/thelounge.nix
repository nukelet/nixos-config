{ inputs, lib, config, ... }:

let
    # TODO: change this back to `config.networking.domain`
    #       once we ditch the old domain name
    # baseDomain = "nukelet.com";
    # subDomain = "irc";
    # fullDomain = "${subDomain}.${baseDomain}";
    fullDomain = "irc.${config.networking.domain}";
    port = 9000;
in {
    imports = [
        ../optional/nginx.nix
        ../virtualisation
    ];

    virtualisation.oci-containers.backend = "docker";
    virtualisation.oci-containers.containers = {
        thelounge = {
            image = "thelounge/thelounge:latest";
            ports = [ ("127.0.0.1:" + toString(port) + ":9000") ];
            volumes = [
                "/home/nuke/.thelounge:/var/opt/thelounge"
            ];
        };
    };
    networking.firewall.allowedTCPPorts = [ port ];

    services.nginx.virtualHosts.${fullDomain} = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
            proxyPass = "http://localhost:" + toString(port) + "/";
            recommendedProxySettings = false;
            proxyWebsockets = true;
            extraConfig = ''
                proxy_set_header Connection "upgrade";
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header X-Forwarded-For $remote_addr;
	        proxy_set_header X-Forwarded-Proto $scheme;

	        proxy_read_timeout 1d;
            '';
        };
    };
}
