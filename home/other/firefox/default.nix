{ pkgs, ... }:
{
	stylix.targets.firefox.profileNames = ["dev-edition-default"];
	programs.firefox = {
		enable = true;
		package = pkgs.firefox-devedition;
	};
}
