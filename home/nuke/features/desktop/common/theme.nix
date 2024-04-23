{ lib, config, pkgs, ... }:

{
    home.packages = [ pkgs.dconf ];
    home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        name = "Bibata-Modern-Ice";
        size = 24;
        package = pkgs.bibata-cursors;
    };

    dconf.settings = {
        "org/gnome/desktop/background" = {
            picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
        };

        "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
        };
    };

    qt = {
        enable = true;
        platformTheme = "gnome";
        style.name = "adwaita-dark";
    };

    gtk = {
        enable = true;

        theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome-themes-extra;
        };

        iconTheme.package = pkgs.gruvbox-dark-icons-gtk;
        iconTheme.name = "gruvbox-dark";
    };
}
