{ lib, config, inputs, ... }: {
    imports = [
        inputs.flux.nixosModules.default
        ./servers
    ];
    options = {
        server.minecraft.enable = lib.mkEnableOption "minecraft server";
    };
    config = let cfg = config.server.minecraft; in lib.mkIf cfg.enable {
         nixpkgs.overlays = [ inputs.flux.overlays.default ];
        flux = {
            enable = true;
        };
    };
}
