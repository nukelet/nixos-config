{ inputs, ... }:

{
    programs.gnupg.agent = {
        enable = true;
        pinentryFlavor = "curses";
    };
}
