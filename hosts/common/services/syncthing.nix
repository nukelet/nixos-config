{ pkgs, inputs, lib, config, ... }:

{
    services.syncthing = {
        enable = true;
        user = "nuke";
        dataDir = "/home/nuke/sync";
        configDir = "/home/nuke/.config/syncthing";
        overrideDevices = true;
        overrideFolders = true;
        # disable annoying request to collect anonymous data
        settings.options.urAccepted = -1;
        guiAddress = "127.0.0.1:8384";
        settings = {
            devices = {
                "elpis" = { id = "K4LHBHH-LWHPVHT-PTFFHDD-ONVXKAM-OP6V3T2-PNBYTWN-GVI6GZS-J5DP7A4"; };
            };
                "zanarkand" = { id = "test"; };
                "amaurot" = { id = "test"; };

            folders = {
                "sync" = {
                    path = "/home/nuke/sync";
                    devices = [ "elpis" ];
                };
            };
        };
    };

    networking.firewall.allowedTCPPorts = [ 8384 22000 ];
    networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
