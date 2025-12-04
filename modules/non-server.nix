{ inputs, pkgs, config, ... }: {
	imports = [
		./spoofdpi.nix
		./dm.nix
		./mopidy.nix
		./wireguard.nix
		./gnome.nix
	];
	services.spoofdpi.enable = true;
	environment.systemPackages = [
		inputs.notbalds.packages.${pkgs.stdenv.hostPlatform.system}.bald
		inputs.notbalds.packages.${pkgs.stdenv.hostPlatform.system}.cwe-client-cli
	];

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


	services.yggdrasil = {
		enable = true;
		settings.Peers = [ "tcp://ip4.01.msk.ru.dioni.su:9002" ];
		settings.IfName = "yggd";
	};
}
