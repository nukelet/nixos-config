{ input, outputs, ... }:

{
    imports = [
        ./openssh.nix
	./gnupg.nix
	./sops.nix
    ];

    nixpkgs = {
        config = {
            allowUnfree = true;
        };
    };

    hardware.enableRedistributableFirmware = true;
    networking.domain = "nukelet.online";
}
