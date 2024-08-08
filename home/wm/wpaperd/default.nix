{ ... }:
{
	stylix.targets.wpaperd.enable = false;
	programs.wpaperd = {
		enable = true;
		settings = {
			any = {
				path = "${../../../stylix/wallpapers}";
				duration = "5m";
			};
		};
	};
}
