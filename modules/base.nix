{ inputs, pkgs, ... }: {
    imports = [
        inputs.stylix.nixosModules.stylix
        inputs.nur.nixosModules.nur
        ../stylix
        ./rust.nix
        ./starship
    ];
    config.environment.systemPackages = [ pkgs.comma ];
}
