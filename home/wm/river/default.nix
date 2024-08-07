{ pkgs, sys, ... }: {
	wayland.windowManager.river = {
		enable = true;
		settings = import ./settings.nix { inherit pkgs; inherit sys; };
	};
}
