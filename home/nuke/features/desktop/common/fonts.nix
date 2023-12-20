{ pkgs, ... }:

{
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
        nerdfonts
        source-han-sans
        (nerdfonts.override {
            fonts = [ "FiraCode" "DroidSansMono" ];
         })
    ];
}
