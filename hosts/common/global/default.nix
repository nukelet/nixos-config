{ inputs, lib, pkgs, outputs, ... }:

{
    # Enable Flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    imports = [
        ./openssh.nix
        ./gnupg.nix
        ./sops.nix
        ./tailscale.nix
        inputs.home-manager.nixosModules.home-manager
    ];

    nixpkgs = {
        config = {
            allowUnfree = true;
        };
    };

    hardware.enableRedistributableFirmware = true;
    networking.domain = "nukelet.com";
    services.resolved.enable = lib.mkDefault true;

    environment.systemPackages = with pkgs; [
        bash
        zsh
        neovim
        wget
        curl
        git
        tree
        htop
        unzip
        ripgrep
        tmux

        dnsutils
        inetutils
        toybox
        tcpflow
        findutils

        pciutils

        gnupg
	pinentry-curses
	sops
    ];

    programs.command-not-found.enable = false;

    programs.neovim = {
        enable = true;
        defaultEditor = true;
    };

    programs.zsh.enable = true;
}
