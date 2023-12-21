{ pkgs, ... }:

let
    steam-with-pkgs = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libpng
            libpulseaudio
            stdenv.cc.cc.lib
            mangohud
        ];
    };
in
{

    home.packages = with pkgs; [
        steam
        mangohud
        protontricks
    ];
}
