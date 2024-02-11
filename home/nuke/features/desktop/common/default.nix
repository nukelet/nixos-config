{ lib, config, pkgs, ... }:

{
    imports = [
        ./firefox.nix
        ./kitty.nix
        ./fonts.nix
        ./fcitx.nix
    ];

    xdg.mimeApps.enable = true;
}
