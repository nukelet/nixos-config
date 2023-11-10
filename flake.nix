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

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-index-database, ... }@inputs:
  let
    inherit (self) outputs;
    systems = [ "x86_64-linux" ];
  in
  {
    nixosConfigurations = {
      "thavnair" = nixpkgs.lib.nixosSystem {
        modules = [
	  ./hosts/thavnair
	  nix-index-database.nixosModules.nix-index
	];
	specialArgs = { inherit inputs outputs; };
      };
    };
  };
}
