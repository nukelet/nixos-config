{ inputs, lib, config, pkgs, ... }:

{
    services.tailscale.enable = true;
    environment.systemPackages = [ pkgs.tailscale ];
}
