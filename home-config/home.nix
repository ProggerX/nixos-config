{ ... }:
{
    home.username = "proggerx";
    home.homeDirectory = "/home/proggerx";

    imports = [
        ./pkgs.nix
		./emanote
		./zsh
		./foot
        ./starship
	    ./fish
	    ./eww
	    ./neovim
        ./alacritty
		./cursor.nix
		./dotfiles.nix
		./mako
		./gtk.nix
		./hyprland
		./pass
    ];

    home.stateVersion = "24.05";

    programs.home-manager.enable = true;
}
