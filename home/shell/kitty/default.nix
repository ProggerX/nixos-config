{ inputs, system, ... }:
let unstable = import inputs.unstable { inherit system; }; in {
    programs.kitty = {
		enable = true;
		package = unstable.kitty;
		settings = {
			cursor_trail = 3;
			enable_audio_bell = "no";
		};
	};
}
