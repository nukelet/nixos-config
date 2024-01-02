{ pkgs, ... }:
{
    home.packages = with pkgs; [
        lua-language-server
        pyright
        rust-analyzer
    ];
}
