# import and decrypt secrets here
{ inputs, agenix, personal-secrets, ... }:

let
    personal-secrets = inputs.personal-secrets;
in
{
    imports = [
        agenix.nixosModules.default
    ];

    age.secrets.nuke-hashed-password = {
        file = "${personal-secrets}/nuke-hashed-password.age";
    owner = "root";
    group = "root";
    };

}
