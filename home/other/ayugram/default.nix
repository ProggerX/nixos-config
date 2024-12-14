{ pkgs, inputs, ... }: {
	home.packages = [
		inputs.ayugram-desktop.packages.${pkgs.system}.ayugram-desktop
	];
}
