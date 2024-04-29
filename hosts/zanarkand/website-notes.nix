{ pkgs, inputs, lib, config, ... }:

let
    baseDomain = config.networking.domain;
    subDomain = "notes";
    fullDomain = "${subDomain}.${baseDomain}";
    port = "9001";
in {
    imports = [
        ../common/optional/nginx.nix
    ];

    environment.systemPackages = [ pkgs.emanote ];

    systemd.services.website-notes = {
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        description = "Web server with nukelet's website notes.";
        serviceConfig = {
            Type = "simple";
            User = "nuke";
            ExecStart = ''
                ${pkgs.lib.getExe pkgs.emanote} \
                --layers "/home/nuke/sync/notes/permanent" \
                run --host=127.0.0.1 --port=${port}
            '';
        };
    };

    services.nginx.virtualHosts.${fullDomain} = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
            proxyPass = "http://localhost:${port}/";
            proxyWebsockets = true;
            recommendedProxySettings = true;
        };
    };
}
