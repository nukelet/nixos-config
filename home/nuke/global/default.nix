{ inputs, lib, pkgs, config, outputs, ... }:
{
    imports = [
        ../features/cli
        # ../features/nvim
    ];

    nixpkgs = {
        config = {
            allowUnfree = true;
            allowUnfreePredicate = (_: true);
        };
    };

    nix = {
        package = lib.mkDefault pkgs.nix;
        settings = {
            experimental-features = [ "nix-command" "flakes" ];
            warn-dirty = true;
        };
    };

    systemd.user.startServices = "sd-switch";

    programs = {
        home-manager.enable = true;
        git.enable = true;
    };

    home = {
        username = "nuke";
        homeDirectory = "/home/${config.home.username}";
        stateVersion = "23.11";
    };
}
