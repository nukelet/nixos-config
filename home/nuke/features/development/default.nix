{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        gcc
        nodejs

        cargo

        nix-prefetch-github
    ];
}
