{ pkgs, ... }:

{
    services.xserver = {
        enable = true;

        displayManager.sddm.enable = true;
        displayManager.defaultSession = "none+i3";

        desktopManager = {
            xterm.enable = false;
        };

        windowManager.i3 = {
            enable = true;
        };
    };
}
