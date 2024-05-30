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
		./dunst
		./hyprland
		./pass
		./wpaperd
		./waybar
    ];

    home.stateVersion = "24.05";

    programs.home-manager.enable = true;
}
