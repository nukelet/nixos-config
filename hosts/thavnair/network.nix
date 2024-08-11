{ config, pkgs, ... }:

{
    networking = {
        interfaces.enp1s0.ipv4.addresses = [{
            address = "192.168.15.14";
            prefixLength = 24;
        }];

        defaultGateway = {
            address = "192.168.15.1";
            interface = "enp1s0";
        };

        nameservers = [ "1.1.1.1" "8.8.8.8" ];
    };

    services.resolved.enable = false;
    # services.dnsmasq = {
    #     enable = true;
    #     extraConfig = ''
    #        interface=enp0s31f6
    #        # gateway
    #        dhcp-option=3,143.106.50.65
    #        # dns servers
    #        dhcp-option=6,143.106.8.30,143.106.2.5
    #        dhcp-range=143.106.50.65,143.106.50.126,5m
    #     '';
    # };
    #
    # networking.firewall.allowedTCPPorts = [
    #     # pixiecore
    #     64172
    # ];
    # networking.firewall.allowedUDPPorts = [
    #     # pixiecore
    #     67 69 4011
    #     # dnsmasq
    #     53 67
    # ];
}
