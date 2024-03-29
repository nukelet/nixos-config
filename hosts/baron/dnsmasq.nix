{ pkgs, ... }:

{
    services.dnsmasq = {
        enable = true;
        extraConfig = ''
           interface=enp3s0
           # gateway
           dhcp-option=3,143.106.50.65
           # dns servers
           dhcp-option=6,143.106.8.30,143.106.2.5
           dhcp-range=143.106.50.65,143.106.50.126,5m
        '';
    };

    networking.firewall.allowedTCPPorts = [
        # pixiecore
        64172
    ];
    networking.firewall.allowedUDPPorts = [
        # pixiecore
        67 69 4011
        # dnsmasq
        53 67
    ];
}
