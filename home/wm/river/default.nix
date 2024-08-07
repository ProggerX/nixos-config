{ pkgs, lib, ... }: {
	wayland.windowManager.river = {
		enable = true;
		settings = import ./settings.nix { inherit pkgs; inherit lib; };
		extraConfig = "rivertile -view-padding 6 -outer-padding 6";
	};
}
