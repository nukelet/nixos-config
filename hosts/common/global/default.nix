{ input, outputs, ... }:

{
    imports = [
        ./openssh.nix
    ];

    nixpkgs = {
        config = {
            allowUnfree = true;
        };
    };

    hardware.enableRedistributableFirmware = true;
    networking.domain = "nukelet.online";
}
