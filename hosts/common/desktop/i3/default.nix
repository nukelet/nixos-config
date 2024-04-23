{ pkgs, ... }:

{
    services.xserver = {
        enable = true;

        desktopManager = {
            xterm.enable = false;
        };

        windowManager.i3 = {
            enable = true;
        };
    };

    services.displayManager.sddm.enable = true;
    services.displayManager.defaultSession = "none+i3";

}
