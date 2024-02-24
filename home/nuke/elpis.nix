{ config, pkgs, inputs, outputs, ... }:

{
    imports = [
        ./global
        ./features/development
        ./features/virtualisation
        ./features/desktop/common
        ./features/desktop/i3
        ./features/messaging/discord.nix
        ./features/misc
        ./features/nvim
        ./features/gaming/heroic.nix
    ];
}
