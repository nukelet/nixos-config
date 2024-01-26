{ pkgs, ... }:

{
    home.packages = with pkgs; [
        qbittorrent
        vlc
        inkscape
        krita
        spotify
    ];
}
