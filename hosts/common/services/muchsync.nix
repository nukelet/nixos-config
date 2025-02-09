{ config, pkgs, ... }:

{
    environment.systemPackages = [ pkgs.notmuch pkgs.muchsync ];
    programs.notmuch.enable = true;
    programs.muchsync.enable = true;
}
