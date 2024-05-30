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
		./wofi
	    ./eww
	    ./neovim
		./dotfiles.nix
		./dunst
		./hyprland
		./pass
		./wpaperd
    ];

    home.stateVersion = "24.05";

    programs.home-manager.enable = true;
}
