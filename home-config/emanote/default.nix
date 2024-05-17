{ ... }:
let
	emanote = import (builtins.fetchTarball "https://github.com/srid/emanote/archive/master.tar.gz");
in {
	imports = [ emanote.homeManagerModule ];
	services.emanote = {
		enable = true;
		notes = [
			"/home/proggerx/zettle"
		];
		package = emanote.packages.${builtins.currentSystem}.default;
	};
}
