{ outputs, lib, config }:

let
    inherit (config.networking) hostName;
    hosts = outputs.nixosConfigurations;
    pubKey = host: ../../${host}/ssh_host_ed25519_key.pub;
in
{
    services.openssh = {
        enable = true;

        settings = {
            # TODO: disable this when we finish setting up secrets!
            PasswordAuthentication = true;
            PermitRootLogin = "no";
        };

        hostKeys = [{
            path = "/etc/ssh/ssh_host_ed25519_key";
            type = "ed25519";
        }];
    };

    programs.ssh = {
        # This ingenious trick is shamelessly stolen from Misterio77's config:
        # https://github.com/Misterio77/nix-config/blob/main/hosts/common/global/openssh.nix
        # We add to out ssh.knownHosts the public keys for each host defined in nixosConfigurations
        knownHosts = bultins.mapAttrs
            (name: _: {
                publicKeyFile = pubKey name;
            })
            hosts;
    };
}
