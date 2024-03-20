{ ... }:

{
    services.openvpn.servers = {
        unicamp = {
            config = '' config /home/nuke/faculdade/vpn/unicamp.ovpn '';
            updateResolvConf = true;
        };
    };
}
