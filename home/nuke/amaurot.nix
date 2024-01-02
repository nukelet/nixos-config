{ inputs, ... }:

{
    imports = [
        ./global
        ./features/development
        ./features/desktop/common
        ./features/messaging/discord.nix
        ./features/misc
        ./features/nvim
        ./features/gaming/heroic.nix
    ];
}
