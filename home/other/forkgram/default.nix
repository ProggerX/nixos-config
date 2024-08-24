{ pkgs, lib, ... }:
let pkg = pkgs.telegram-desktop.overrideAttrs (old: rec {
    name = "forkgram";
    version = "5.1.8";
    src = pkgs.fetchFromGitHub {
        owner = "forkgram";
        fetchSubmodules = true;
        repo = "tdesktop";
        rev = "v${version}";
        hash = "sha256-ZLzJak6Rn5/Ys9qTQLdqX0FqwXe3OmjgLSvZPSRloZ8=";
    };
});
in {
    home.packages = lib.mkIf false [
        pkg
    ];
}
