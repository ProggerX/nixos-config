{ inputs, pkgs, config, ... }: {
	imports = [
		./spoofdpi.nix
		./dm.nix
		./mopidy.nix
		./wireguard.nix
	];
	services.spoofdpi.enable = true;
	environment.systemPackages = [
		inputs.notbalds.packages.${pkgs.stdenv.hostPlatform.system}.bald
		inputs.notbalds.packages.${pkgs.stdenv.hostPlatform.system}.cwe-client-cli
	];
	hardware.xpadneo.enable = true;

	wg = {
		enable = true;
		endpoint = "5.35.87.192:51820";
		tunnel = true;
		address =
			if config.isLaptop
				 then "10.7.0.5/24"
				 else "10.7.0.4/24";
		keys = {
			public = "eBynlYh1/1vwqD8KQ2PhwrPVUWnZ7dEoqrZ8iLyNVS0=";
			privateFile = 
				if config.isLaptop
					then config.age.secrets.wg-laptop.path
					else config.age.secrets.wg-pc.path;
			preshared =
				if config.isLaptop
					then "70ZyNXIKUfEMPk+eMDClvLDCd5AOvQXRfGqxEj4Lt3s="
					else "a6BWU/8BnZ/HQHIwWpTnb0G86Sfosj2zdQuWFmOjTZ4=";
		};
	};
}
