{ inputs, outputs, ... }:

{
    imports = [
        ./global
        ./features/development
        ./features/desktop/common

        ./features/desktop/sway

        ./features/messaging/discord.nix
        ./features/misc
        ./features/nvim
        ./features/gaming/heroic.nix
    ];

    wayland.windowManager.sway.config = {
        input = {
            "1267:12586:ELAN0504:01_04F3:312A_Touchpad" = {
                dwt = "enabled"; # disable touchpad while typing
                tap = "enabled";
                middle_emulation = "enabled";
            };
        };
    };
}
