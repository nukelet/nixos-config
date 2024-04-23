{ lib, config, pkgs, ... }:

let
    mod = "Mod4";
in
{
    imports = [
        ../common
        ./rofi.nix
    ];

    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
        i3lock-fancy-rapid
        i3status
        flameshot
        libnotify
        feh
        playerctl
        xclip
    ];

    xsession.enable = true;
    xsession.windowManager.i3 = {
        enable = true;
        config = {
            modifier = mod;
            floating.modifier = mod;

            fonts = {
                names = [ "Fira Code Nerd Font" ];
                size = 12.0;
            };

            bars = [
                {
                    position = "bottom";
                    statusCommand = "${pkgs.i3status}/bin/i3status -c ${./i3status-config}";
                    fonts = {
                        names = [ "Fira Code Nerd Font" ];
                        size = 12.0;
                    };

                }
            ];

            startup = [
                {
                    command = "${pkgs.feh}/bin/feh --bg-fill ~/wallpapers/mhach.jpg";
                    always = true;
                    notification = false;
                }

                {
                    command = "${pkgs.fcitx5}/bin/fcitx5 -d";
                    always = true;
                    notification = false;
                }

                {
                    command = "${pkgs.libnotify}/bin/notify-send 'Config loaded'";
                    always = true;
                    notification = false;
                }

                {
                    command = "${pkgs.i3}/bin/i3-msg 'workspace 9; exec ${pkgs.easyeffects}/bin/easyeffects'";
                    notification = false;
                }

                # TODO: this is specific to the `elpis` host, maybe move somewhere else
            #     {
            #         command = ''
            #             ${pkgs.xorg.xrandr}/bin/xrandr --auto && ${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --primary --output HDMI-0 --left-of DP-0
            #         '';
            #         notification = false;
            #     }
           ];

            keybindings = lib.mkOptionDefault {
                # NOTE: these should probably be using ${pkgs.<...>}/bin/<...>, but
                #       I guess having it like this makes it possible to reuse the
                #       generated config file in ~/.config/i3

                # start terminal
                "${mod}+Return" = "exec kitty";
                # kill focused window
                "${mod}+Shift+q" = "kill";
                # start rofi
                "${mod}+d" = "exec --no-startup-id rofi -show run";
                # lock screen
                "${mod}+Control+l" = "exec --no-startup-id i3lock 20 20";

                # change focus
                "${mod}+h" = "focus left";
                "${mod}+j" = "focus down";
                "${mod}+k" = "focus up";
                "${mod}+l" = "focus right";

                # move focused window
                "${mod}+Shift+h" = "move left";
                "${mod}+Shift+j" = "move down";
                "${mod}+Shift+k" = "move up";
                "${mod}+Shift+l" = "move right";

                # split horizontally
                "${mod}+Shift+v" = "split v";
                # split vertically
                "${mod}+v" = "split v";

                # enter fullscreen mode for focused container
                "${mod}+f" = "fullscreen toggle";

                # change container layout
                "${mod}+s" = "layout stacking";
                "${mod}+w" = "layout tabbed";
                "${mod}+e" = "layout toggle split";

                # toggle tiling/floating
                "${mod}+Shift+space" = "floating toggle";

                # move workspace to left and right monitors
                "${mod}+Shift+bracketleft" = "move workspace to output left";
                "${mod}+Shift+bracketright" = "move workspace to output right";

                # too lazy to write these more elegantly lol
                "${mod}+1" = "workspace number 1";
                "${mod}+2" = "workspace number 2";
                "${mod}+3" = "workspace number 3";
                "${mod}+4" = "workspace number 4";
                "${mod}+5" = "workspace number 5";
                "${mod}+6" = "workspace number 6";
                "${mod}+7" = "workspace number 7";
                "${mod}+8" = "workspace number 8";
                "${mod}+9" = "workspace number 9";
                "${mod}+10" = "workspace number 10";

                "${mod}+Shift+1" = "move container to workspace number 1";
                "${mod}+Shift+2" = "move container to workspace number 2";
                "${mod}+Shift+3" = "move container to workspace number 3";
                "${mod}+Shift+4" = "move container to workspace number 4";
                "${mod}+Shift+5" = "move container to workspace number 5";
                "${mod}+Shift+6" = "move container to workspace number 6";
                "${mod}+Shift+7" = "move container to workspace number 7";
                "${mod}+Shift+8" = "move container to workspace number 8";
                "${mod}+Shift+9" = "move container to workspace number 9";
                "${mod}+Shift+10" = "move container to workspace number 10";

                # reload the config file
                "${mod}+Shift+c" = "reload";
                # restart i3 inplace (preserving layout/session)
                "${mod}+Shift+r" = "restart";
                "${mod}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";

                # enter resize mode
                "${mod}+r" = "mode resize";


                # screenshots
                "Print" = "exec ${pkgs.flameshot}/bin/flameshot gui -p ~/screenshots";
            };

            modes.resize = {
                "h" = "resize shrink width 10 px or 10 ppt";
                "k" = "resize grow height 10 px or 10 ppt";
                "j" = "resize shrink height 10 px or 10 ppt";
                "l" = "resize grow width 10 px or 10 ppt";
                "Escape" = "mode default";
                "Return" = "mode default";
                "${mod}+r" = "mode default";
            };
        };
    };

}
