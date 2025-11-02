{ inputs, pkgs, config, ... }: {
	imports = [
		./spoofdpi.nix
		./dm.nix
		./mopidy.nix
	];
	services.spoofdpi.enable = true;
	environment.systemPackages = [
		inputs.notbalds.packages.${pkgs.stdenv.hostPlatform.system}.bald
		inputs.notbalds.packages.${pkgs.stdenv.hostPlatform.system}.cwe-client-cli
	];
	hardware.xpadneo.enable = true;

	networking.wireguard = {
		enable = true;
		interfaces = {
			wg0 = {
				ips = [ (if config.isLaptop
						 then "10.7.0.5/24"
						 else "10.7.0.4/24") ];

				listenPort = 51820;

				privateKeyFile =
					if config.isLaptop
						then config.age.secrets.wg-laptop.path
						else config.age.secrets.wg-pc.path;

				fwMark = "0xca6c";

				peers = [
					{ 
						name = "me";
						publicKey = "eBynlYh1/1vwqD8KQ2PhwrPVUWnZ7dEoqrZ8iLyNVS0=";
						presharedKey = if config.isLaptop
							then "70ZyNXIKUfEMPk+eMDClvLDCd5AOvQXRfGqxEj4Lt3s="
							else "a6BWU/8BnZ/HQHIwWpTnb0G86Sfosj2zdQuWFmOjTZ4=";
						allowedIPs = [
							"0.0.0.0/6"
							"4.0.0.0/8"
							"5.0.0.0/11"
							"5.32.0.0/15"
							"5.34.0.0/16"
							"5.35.0.0/18"
							"5.35.64.0/20"
							"5.35.80.0/22"
							"5.35.84.0/23"
							"5.35.86.0/24"
							"5.35.87.0/25"
							"5.35.87.128/26"
							"5.35.87.193/32"
							"5.35.87.194/31"
							"5.35.87.196/30"
							"5.35.87.200/29"
							"5.35.87.208/28"
							"5.35.87.224/27"
							"5.35.88.0/21"
							"5.35.96.0/19"
							"5.35.128.0/17"
							"5.36.0.0/14"
							"5.40.0.0/13"
							"5.48.0.0/12"
							"5.64.0.0/10"
							"5.128.0.0/9"
							"6.0.0.0/7"
							"8.0.0.0/5"
							"16.0.0.0/4"
							"32.0.0.0/3"
							"64.0.0.0/2"
							"128.0.0.0/1"
						];
						endpoint = "5.35.87.192:51820";
						persistentKeepalive = 25;
					}
				];
			};
		};
	};
}
