{ ... }:
{
    home.username = "proggerx";
    home.homeDirectory = "/home/proggerx";

    imports = [
        ./pkgs.nix
		./other
		./wm
		./shell
    ];

    home.stateVersion = "24.05";

    programs.home-manager.enable = true;
}
