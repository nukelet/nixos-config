{ config, pkgs, ... }:

{
    # Automatically setup virt-manager connections
    dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
            autoconnect = ["qemu:///system"];
            uris = ["qemu:///system"];
        };
    };
}
