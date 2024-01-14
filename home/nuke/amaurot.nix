{ inputs, outputs, ... }:

{
    imports = [
        ./global
        ./features/development
        ./features/desktop/common
        # ./features/desktop/sway
        ./features/desktop/hyprland
        ./features/messaging/discord.nix
        ./features/misc
        ./features/nvim
        ./features/gaming/heroic.nix
    ];
}
