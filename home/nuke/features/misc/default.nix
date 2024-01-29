{ pkgs, lib, ... }:

# ugly temporary hack to fix Obsidian's dependence
# on an EOL Electron version
let 
    obsidian = pkgs.obsidian.override {
        electron = pkgs.electron_25.overrideAttrs (_: {
            preFixup = "patchelf --add-needed ${pkgs.libglvnd}/lib/libEGL.so.1 $out/bin/electron"; # NixOS/nixpkgs#272912
            meta.knownVulnerabilities = [ ]; # NixOS/nixpkgs#273611
        });
    };
in
{
    home.packages = with pkgs; [
        qbittorrent
        vlc
        inkscape
        krita
        spotify
        obsidian
    ];
}
