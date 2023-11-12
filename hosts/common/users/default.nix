{ pkgs, config, ... }:
let
    ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
    sops = config.sops;
in
{
    users.mutableUsers = false;
    users.users = {
        nuke = {
            isNormalUser = true;
            shell = pkgs.zsh;
            extraGroups = [
                "wheel"
                "video"
                "audio"
            ] ++ ifTheyExist [
                "docker"
            ];

            hashedPasswordFile = sops.secrets.nuke-hashed-password.path;
            # password = "changeme";
        };

        root = {
            password = "changeme";
        };
    };

    sops.secrets.nuke-hashed-password = {
        sopsFile = ../secrets.yaml;
        neededForUsers = true;
    };
}
