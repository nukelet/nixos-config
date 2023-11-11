{
    description = "nukelet's personal NixOS flake";

    nixConfig = {
        experimental-features = [ "nix-command" "flakes" ];
        substituters = [
            "https://cache.nixos.org/"
        ];

        extra-substituters = [
            "https://nix-community.cachix.org"
        ];

        extra-trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
    };

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager/release-23.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        agenix = {
            url = "github:ryantm/agenix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        personal-secrets = {
            url = "git+ssh://git@github.com/nukelet/nixos-secrets.git";
            flake = false;
        };

        nix-index-database = {
            url = "github:Mic92/nix-index-database";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, nix-index-database, agenix, ... }@inputs:
    let
        inherit (self) outputs;
        baseModules = [
            ./secrets/default.nix
            nix-index-database.nixosModules.nix-index
            { environment.systemPackages = [ agenix.packages.x86_64-linux.default ]; }
        ];
    in
    {
        nixosConfigurations = {
            "thavnair" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./hosts/thavnair
                ] ++ baseModules;
                specialArgs = { inherit inputs outputs agenix; };
            };
        };
    };
}
