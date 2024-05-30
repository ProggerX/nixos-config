{ ... }:
{
	programs.wpaperd = {
		enable = true;
		settings = {
			default = {
				path = "/etc/nixos/walls.jpg";
			};
		};
	};
}
