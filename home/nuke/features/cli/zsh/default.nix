{ pkgs, lib, ... }:

{
    programs.zsh = {
        enable = true;

        enableCompletion = true;
        enableAutosuggestions = true;

        history = {
            save = 100000;
            size = 100000;
        };

        initExtra = ''
            [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}
        '';

        oh-my-zsh = {
            enable = true;
            plugins = [ "git" "sudo" "history" ];
        };


        plugins = [
            {
                name = "zsh-autosuggestions";
                src = pkgs.fetchFromGitHub {
                    owner = "zsh-users";
                    repo = "zsh-autosuggestions";
                    rev = "v0.7.0";
                    hash = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
                };
            }

            {
                name = "zsh-syntax-highlighting";
                src = pkgs.fetchFromGitHub {
                    owner = "zsh-users";
                    repo = "zsh-syntax-highlighting";
                    rev = "0.8.0";
                    hash = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
                };
            }

            # {
            #     name = "powerlevel10k";
            #     file = "powerlevel10k.zsh-theme";
            #     src = pkgs.fetchFromGitHub {
            #         owner = "romkatv";
            #         repo = "powerlevel10k";
            #         rev = "v1.19.0";
            #         hash = "sha256-+hzjSbbrXr0w1rGHm6m2oZ6pfmD6UUDBfPd7uMg5l5c=";
            #     };
            # }

            {
                name = "powerlevel10k";
                src = pkgs.zsh-powerlevel10k;
                file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            }



        ];
    };
}
