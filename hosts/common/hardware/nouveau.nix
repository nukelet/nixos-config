{ config, lib, pkgs, ... }:

{
    boot.kernelPackages = pkgs.linuxPackages_testing;

    # Enable nouveau
    boot.blacklistedKernelModules = [ "nvidia" "nvidia_uvm" ];
    boot.initrd.kernelModules = [ "nouveau" ];
    boot.kernelParams = [
        "nouveau.config=NvGspRm=1"
        "nouveau.debug=info,VBIOS=info,gsp=debug"
    ];

    services.xserver.enable = true;
    services.xserver.videoDrivers = lib.mkForce [ "modesetting" ];

    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };
}
