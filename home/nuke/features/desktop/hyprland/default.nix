{ lib, pkgs, ... }:

let
    hyprland = pkgs.inputs.hyprland.hyprland.override { wrapRuntimeDeps = false; };
    xdg-desktop-portal-hyprland = pkgs.inputs.hyprland.xdg-desktop-portal-hyprland.override { inherit hyprland; };

    workspaceKeybinds = builtins.concatLists (builtins.genList
    (x:
        let
            key = builtins.toString x;
            workspace = builtins.toString (if x == 0 then 10 else x);
        in

          ["$mod, ${key}, workspace, ${workspace}"
          "$mod SHIFT, ${key}, movetoworkspace, ${workspace}"]
    ) 10);

in
{
    imports = [
        ../common
    ];

    xdg.portal = {
        extraPortals = [ xdg-desktop-portal-hyprland ];
        configPackages = [ hyprland ];
    };

    home.packages = with pkgs; [
        xdg-utils # for opening default programs when clicking links
        glib # gsettings
        dracula-theme # gtk theme
        swaylock
        swayidle
        grim # screenshot functionality
        slurp # screenshot functionality
        wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
        bemenu # wayland clone of dmenu
        mako # notification system developed by swaywm maintainer
        wdisplays # tool to configure displays
    ];

    wayland.windowManager.hyprland = {
        enable = true;
        package = hyprland;
        systemd = {
            enable = true;
            extraCommands = lib.mkBefore [
                "systemctl --user stop graphical-session.target"
                "systemctl --user start hyprland-session.target"
            ];
        };
    };

    wayland.windowManager.hyprland.settings = {
        "$mod" = "SUPER";    
        bind = [
            # keybinds here
        ] ++ workspaceKeybinds;
    };

    wayland.windowManager.hyprland.plugins = [
        pkgs.inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    ];

    programs.wofi = {
        enable = true;
    };
}
