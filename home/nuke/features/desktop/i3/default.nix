{ lib, config, pkgs, ... }:

let
    mod = "Mod4";
in
{
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
        i3status
        rofi
        nerdfonts
        source-han-sans
    ];

    xsession.windowManager.i3 = {
        enable = true;
        config = {
            modifier = mod;
            fonts = [ "DejaVu Sans Mono 14" ];
        };
    };

}
