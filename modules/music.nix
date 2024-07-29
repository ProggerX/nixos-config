{ inputs, ... }: {
	imports = [
		inputs.yandex-music.nixosModules.default
	];
}
