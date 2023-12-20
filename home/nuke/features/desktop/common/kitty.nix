{ lib, config, pkgs, ... }:

{
    programs.kitty = {
        enable = true;

        # TODO: font config
        font = {
            name = "FiraCode Nerd Font";
            size = 12;
        };

        settings = {
            scrollback_lines = 10000;
        };
    };
}
