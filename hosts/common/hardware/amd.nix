{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        radeontop
        glxinfo
    ];

    hardware.opengl.enable = true;
}
