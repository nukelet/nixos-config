{ config, pkgs, ... }:

{
    environment.systemPackages = [ pkgs.notmuch pkgs.muchsync ];
}
