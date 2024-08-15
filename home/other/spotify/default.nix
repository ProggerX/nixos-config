{ pkgs, inputs, config, ... }:
let
	spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
	imports = [inputs.spicetify-nix.homeManagerModules.default];
	programs.spicetify = {
		enable = true;
		theme = spicePkgs.themes.onepunch;

		enabledExtensions = with spicePkgs.extensions; [
			autoSkipVideo
			keyboardShortcut
			shuffle
			playlistIcons
			seekSong
			adblock
			fullAppDisplay
			loopyLoop
			popupLyrics
		];
	};
}
