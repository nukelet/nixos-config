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
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        sops-nix = {
            url = "github:Mic92/sops-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-index-database = {
            url = "github:Mic92/nix-index-database";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland = {
            url = "github:hyprwm/Hyprland";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland-plugins = {
            url = "github:hyprwm/hyprland-plugins";
            inputs.hyprland.follows = "hyprland";
        };

        # TODO: get this to work
        # plasma-manager = {
        #     url = "github:pjones/plasma-manager";
        #     inputs.nixpkgs.follows = "nixpkgs";
        #     inputs.home-manager.follows = "home-manager";
        # };
    };

    outputs = { self, nixpkgs, home-manager, nix-index-database, ... }@inputs:
    let
        inherit (self) outputs;
        lib = nixpkgs.lib // home-manager.lib;
        baseModules = [
            nix-index-database.nixosModules.nix-index
        ];
        systems = [ "x86_64-linux" ];
        overlays = import ./overlays { inherit inputs outputs; };
        pkgsFor = lib.genAttrs systems (system: import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = builtins.attrValues outputs.overlays;
        });
    in
    {
        nixosConfigurations = {
            "thavnair" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./hosts/thavnair
                ] ++ baseModules;
                specialArgs = { inherit inputs outputs; };
            };

            "zanarkand" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./hosts/zanarkand
                ] ++ baseModules;
                specialArgs = { inherit inputs outputs; };
            };

            "amaurot" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./hosts/amaurot
                ] ++ baseModules;
                specialArgs = { inherit inputs outputs; };
            };
        };

        homeConfigurations = {
            "nuke@thavnair" = lib.homeManagerConfiguration {
                modules = [ ./home/nuke/thavnair.nix ];
                pkgs = pkgsFor.x86_64-linux;
                extraSpecialArgs = { inherit inputs outputs; };
            };

            "nuke@amaurot" = lib.homeManagerConfiguration {
                modules = [
                    ./home/nuke/amaurot.nix
                ];
                pkgs = pkgsFor.x86_64-linux;
                extraSpecialArgs = { inherit inputs outputs; };
            };

            "nuke@zanarkand" = lib.homeManagerConfiguration {
                modules = [ ./home/nuke/zanarkand.nix ];
                pkgs = pkgsFor.x86_64-linux;
                extraSpecialArgs = { inherit inputs outputs; };
            };
        };
    };
}
