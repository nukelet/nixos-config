{ inputs, outputs, ... }:

{
    imports = [
        ./openssh.nix
        ./gnupg.nix
        ./sops.nix
        inputs.home-manager.nixosModules.home-manager
    ];

    nixpkgs = {
        config = {
            allowUnfree = true;
        };
    };

    hardware.enableRedistributableFirmware = true;
    networking.domain = "nukelet.online";
}
