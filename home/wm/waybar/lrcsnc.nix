{ buildGoModule, fetchFromGitHub }:
buildGoModule rec {
	pname = "lrcsnc";
	version = "0.1.0";
	src = fetchFromGitHub {
		owner = "Endg4meZer0";
		repo = pname;
		rev = "v${version}";
		sha256 = "sha256-gKb0cTpCPlyvJFthV1csn8HaVcUvXq+KC+nTT5sGhww=";
	};
	vendorHash = "sha256-ww+SXy29woGlb120sj1oGb4MIQJzpBCKGpUKYsYxTMk=";
	checkPhase = "";
}
