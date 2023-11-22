{ config, pkgs, ... }:

{
    imports = [
        ./zsh.nix
        ./git.nix
    ];

    home.packages = with pkgs; [
        tree
        tig
    ];
}
