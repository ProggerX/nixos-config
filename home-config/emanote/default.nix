{ ... }:
let
	emanote = import (builtins.fetchTarball {
		url = "https://github.com/srid/emanote/archive/master.tar.gz";
		sha256 = "sha256:0haj8wxdgjy4ks8kpaaiz5pg65s2l4x44hai5l6sknfidnqfxfj6";
	});
in {
	imports = [ emanote.homeManagerModule ];
	services.emanote = {
		enable = true;
		notes = [
			"/home/proggerx/zettle"
		];
		package = emanote.packages."x86_64-linux".default;
	};
}
