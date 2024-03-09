{ pkgs, lib, config, ... }:

{
    programs.git = {
        enable = true;
        package = pkgs.gitAndTools.gitFull;
        userName = "Vinicius Peixoto";
        userEmail = "nukelet64@gmail.com";
        extraConfig = {
            init.defaultBranch = "main";
	    user.signing.key = "21A087C50125CF8643D959731C688358233DEE30";
	    commit.gpgSign = lib.mkDefault true;
        };
        lfs.enable = true;
	# ignore the output of flake builds
	ignores = [ "result" ];
    };
}
