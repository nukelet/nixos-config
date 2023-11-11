# import and decrypt secrets here
{ inputs, agenix, personal-secrets, ... }:

{
    imports = [
        inputs.agenix.nixosModules.default
    ];
    
    age.identityPaths = [
        "/root/.ssh/secrets"
    ];
}
