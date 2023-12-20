{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        gcc
        nodejs

        nix-prefetch-github
    ];
}
