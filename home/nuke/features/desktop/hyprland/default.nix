{ pkgs, ... }:

let
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
