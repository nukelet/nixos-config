{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
    users.mutableUsers = false;
    users.users.nuke = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [
            "wheel"
            "video"
            "audio"
        ] ++ ifTheyExist [
            "docker"
        ];

	# hashedPasswordFile = config.age.secrets.nuke-hashed-password.path;
        password = "changeme";
    };
}
