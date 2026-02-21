{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
    ../stylix
    ./rust.nix
    ./starship
  ];
  config.environment.systemPackages = [pkgs.comma];
}
