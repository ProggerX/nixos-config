{ config, pkgs, ... }:
{
    home.username = "proggerx";
    home.homeDirectory = "/home/proggerx";

    imports = [
        ./pkgs.nix
		./neomutt/config.nix
        ./starship/config.nix
	    ./fish/config.nix
	    ./eww/config.nix
	    ./neovim/config.nix
        ./alacritty/config.nix
		./cursor.nix
		./dotfiles.nix
		./mako/config.nix
		./gtk.nix
		./hyprland/config.nix
		./pass/config.nix
		# ./qutebrowser/config.nix
		# ./wayland.nix
    ];

    home.stateVersion = "24.05";

    programs.home-manager.enable = true;
}
