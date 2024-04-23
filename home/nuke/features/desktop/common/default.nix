{ lib, config, pkgs, ... }:

{
    imports = [
        ./firefox.nix
        ./kitty.nix
        ./fonts.nix
        ./fcitx.nix
        ./theme.nix
    ];

    xdg.mimeApps.enable = true;
}
