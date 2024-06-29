{ pkgs, inputs, ... }: {
	nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
	environment.systemPackages = [
		(pkgs.rust-bin.selectLatestNightlyWith(toolchain: toolchain.default.override {
			extensions = [ "rust-analyzer" ];
		}))
	];
}
