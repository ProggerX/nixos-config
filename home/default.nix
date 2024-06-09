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

    home.stateVersion = "24.11";

    programs.home-manager.enable = true;
}
