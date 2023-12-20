{ lib, pkgs, config, ... }:

{
    services.xserver.enable = true;
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;
    # Fix issue with kwallet not unlocking
    security.pam.services.sddm.enableKwallet = true;
    security.pam.services.login.enableKwallet = true;
}

