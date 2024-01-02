{ lib, config, pkgs, ... }:

{
    imports = [
        ../common/kitty.nix
        ../common/fonts.nix
    ];

    wayland.windowManager.sway = {
        enable = true;
        config = rec {
            modifier = "Mod4";
            terminal = "kitty";
        };
    };
}
