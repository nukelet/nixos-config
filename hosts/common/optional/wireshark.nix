{ inputs, lib, config, pkgs, ... }:

{
    environment.systemPackages = [ pkgs.wireshark ];
    programs.wireshark.enable = true;
}
