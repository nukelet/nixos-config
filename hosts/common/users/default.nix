{ pkgs, config, home-manager, ... }:
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
                "users"
                "wheel"
                "video"
                "audio"
            ] ++ ifTheyExist [
                "docker"
            ];

            hashedPasswordFile = sops.secrets.nuke-hashed-password.path;
        };
    };

    sops.secrets.nuke-hashed-password = {
        sopsFile = ../secrets.yaml;
        neededForUsers = true;
    };

    # TODO: make the home-manager configurations a module instead of
    # hard-coding the path like this
    home-manager.users.nuke = import ../../../home/nuke/${config.networking.hostName}.nix;
    security.pam.loginLimits = [
        { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
    ];
}
