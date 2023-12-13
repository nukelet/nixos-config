{ inputs, pkgs, outputs, ... }:

{
    # Enable Flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

    environment.systemPackages = with pkgs; [
        zsh
        neovim
        wget
        curl
        git
        tree
        htop
        unzip

        dnsutils
        inetutils
        toybox
        tcpflow
        findutils

        gnupg
	pinentry-curses
	sops
    ];

    environment.variables.EDITOR = "nvim";

    programs.command-not-found.enable = false;

    programs.neovim = {
        enable = true;
        defaultEditor = true;
    };

    programs.zsh = {
        enable = true;
    };
}
