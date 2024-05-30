{ ... }:
{
    home.username = "proggerx";
    home.homeDirectory = "/home/proggerx";

    imports = [
        ./pkgs.nix
		./emanote
		./zsh
		./kitty
        ./starship
	    ./fish
	    ./eww
	    ./neovim
		./dotfiles.nix
		./mako
		./hyprland
		./pass
		./wpaperd
    ];

    home.stateVersion = "24.05";

    programs.home-manager.enable = true;
}
