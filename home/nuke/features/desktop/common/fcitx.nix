{ config, pkgs, ... }:

{
    i18n.inputMethod = {
        enabled = "fcitx5";
        fcitx5.addons = with pkgs; [
            fcitx5-gtk
            fcitx5-rime
            fcitx5-chinese-addons
            fcitx5-mozc
            fcitx5-nord
        ];
    };
}
