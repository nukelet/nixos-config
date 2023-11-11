# import and decrypt secrets here
{ config, pkgs, agenix, secrets, ... }

{
    imports = [
        agenix.nixosModules.default
    ];
    
    age.identityPaths = [
        "/root/.ssh/secrets"
    ];

    age.secrets."gpg-key" = {
        symlink = true;
        path = "/home/nuke/.gnupg";
    };
}
