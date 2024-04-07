{ pkgs, lib, ... }:

{
    home.packages = with pkgs; [
        qbittorrent
        vlc
        inkscape
        krita
        spotify
        thunderbird

        # productivity
        obsidian
        anki

        # music stuff
        reaper
        qjackctl
        lingot

        # TODO: move somewhere more appropriate, perhaps nvim config
        texlive.combined.scheme-full
        zathura
    ];
}
