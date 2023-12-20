{ lib, config, ... }:

{
    imports = [
        ./firefox.nix
        ./kitty.nix
        ./fonts.nix
    ];
}
