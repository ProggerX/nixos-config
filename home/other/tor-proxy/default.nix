{ pkgs, ... }:
let bridge1 = "obfs4 148.113.143.245:29668 F1EB3EC137D5848FA4C04732DE8E85FD1ED4D329 cert=E2WVIW+lyRBEGIJJp53bo2YgK7bC6f7K6cOoj+7cweuMf7QTqZBhYQqudeUh2KOyvF7zLw iat-mode=0";
bridge2 = "obfs4 46.226.107.60:15864 939A5CFB952ADCE1ACF697264B45D8DABC5C6479 cert=9U+A0Nt7I/URETQ2DieuayL2Wetz4k2AlD2Hy6g+4SQ382MzlqbcOVYGxJVMFYIGQOC7FQ iat-mode=0";
torrc = pkgs.writeText "torrc" ''
	UseBridges 1
	ClientTransportPlugin obfs4 exec ${pkgs.obfs4}/bin/lyrebird
	Bridge ${bridge1}
	Bridge ${bridge2}
''; in {
	systemd.user.services.tor-proxy = {
		Service = {
			ExecStart = "${pkgs.tor}/bin/tor -f ${torrc}";
		};
		Install = {
			WantedBy = [ "graphical-session.target" ];
		};
	};
}
