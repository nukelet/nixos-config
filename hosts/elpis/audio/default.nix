{ config, pkgs, ... }:

{
    # TODO: maybe move this to a separate shared module to avoid
    #       duplication later
    musnix.enable = true;

    # split the "stereo" output of my Teyun Q-24 audio interface
    # into two separate sinks (left: instrument, right: microphone)
    services.pipewire.configPackages = [
        (pkgs.writeTextDir "share/pipewire/pipewire.conf.d/91-teyun-split.conf" ''
            context.modules = [
                {   name = libpipewire-module-loopback
                    args = {
                        node.description = "Q-24 Microphone"
                        capture.props = {
                            node.name = "capture.Q-24_Mic"
                            audio.position = [ AUX1 ]
                            stream.dont-remix = true
                            target.object = "alsa_input.usb-C-Media_Electronics_Inc._HD-II-00.pro-input-0"
                            node.passive = true
                        }
                        playback.props = {
                            node.name = "Q-24_Mic"
                            media.class = "Audio/Source"
                            audio.position = [ MONO ]
                        }
                    }
                }
                {   name = libpipewire-module-loopback
                    args = {
                        node.description = "Q-24 Guitar"
                        capture.props = {
                            node.name = "capture.Q-24_Guitar"
                            audio.position = [ AUX0 ]
                            stream.dont-remix = true
                            target.object = "alsa_input.usb-C-Media_Electronics_Inc._HD-II-00.pro-input-0";
                            node.passive = true
                        }
                        playback.props = {
                            node.name = "Q-24_Guitar"
                            media.class = "Audio/Source"
                            audio.position = [ MONO ]
                        }
                    }
                }
            ]
         '' )
    ];

    # disable automatic BT profile switching (HSP/HFP is stinky)
    # source: https://wiki.archlinux.org/title/PipeWire#Automatic_profile_selection
    services.pipewire.wireplumber.configPackages = [
        (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/11-bluetooth-policy.conf" ''
             wireplumber.settings = {
                 bluetooth.autoswitch-to-headset-profile = false
             }
       '')
    ];

}
