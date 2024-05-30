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
        ./alacritty
		./dotfiles.nix
		./mako
		./gtk.nix
		./hyprland
		./pass
    ];

    home.stateVersion = "24.05";

    programs.home-manager.enable = true;
}
