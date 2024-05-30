{ pkgs }:
pkgs.writeShellScriptBin "idk" ''
	${pkgs.ponysay}/bin/ponysay Hi, I am pony
''
