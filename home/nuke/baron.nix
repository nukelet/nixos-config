{ inputs, ... }:

{
    imports = [
        ./global
        ./features/development
    ];

    programs.git.extraConfig.commit.gpgSign = false;
}
