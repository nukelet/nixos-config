{ inputs, lib, config, ... }:

{
    # Enable the gnome-keyrig secrets vault. 
    # Will be exposed through DBus to programs willing to store secrets.
    services.gnome.gnome-keyring.enable = true;

    # Enable ssh-agent
    programs.ssh.startAgent = true;
}
