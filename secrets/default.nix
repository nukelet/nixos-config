# import and decrypt secrets here
{ inputs, ... }:

let
    personal-secrets = inputs.personal-secrets;
    agenix = inputs.agenix;
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
