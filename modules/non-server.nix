{ inputs, pkgs, ... }: {
    imports = [ ./mpd ];
    environment.systemPackages = [
        inputs.notbalds.packages.${pkgs.stdenv.hostPlatform.system}.bald
        inputs.notbalds.packages.${pkgs.stdenv.hostPlatform.system}.cwe-client-cli
        inputs.lazynix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
}
