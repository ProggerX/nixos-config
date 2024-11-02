{ inputs, ... }: {
    imports = [ inputs.aagl.nixosModules.default ];
	nix.settings = inputs.aagl.nixConfig;
	programs.honkers-railway-launcher.enable = true;
}
