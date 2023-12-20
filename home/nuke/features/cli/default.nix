{ config, pkgs, ... }:

{
    imports = [
        ./zsh
        ./git.nix
    ];

    home.packages = with pkgs; [
        tree
        tig
    ];
}
