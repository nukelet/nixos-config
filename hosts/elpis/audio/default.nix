{ config, pkgs, ... }:

{
    # TODO: maybe move this to a separate shared module to avoid
    #       duplication later
    musnix.enable = true;

    # split the "stereo" output of my Teyun Q-24 audio interface
    # into two separate sinks (left: instrument, right: microphone)
    # environment.etc = {
    #     "pipewire/pipewire.conf.d/91-teyun-split.conf".source = ./91-teyun-split.conf;
    # };

}
