{ inputs, ... }:

{
    sops.secrets.nuke-hashed-password = {
        sopsFile = ./secrets.yaml;
    };

    systemd.services.oximare = {
        wantedBy = ["multi-user.target"];
        after = ["network.target"];
        description = "Start the Oximare discord bot.";
        serviceConfig = {
            User = "nuke";
            ExecStart = ''${inputs.oximare}'';
            Environment = ''OXIMARE_DISCORD_TOKEN=""'';
        };
    };
}
