{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        gcc
        nodejs
        python312

        cargo

        nix-prefetch-github
    ];
}
