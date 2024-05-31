{ ... }:
{
	programs.wpaperd = {
		enable = true;
		settings = {
			default = {
				path = "/etc/nixos/stylix/walls.jpg";
			};
		};
	};
}
