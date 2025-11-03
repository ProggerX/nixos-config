{ config, lib, ... }: {
	options.wg = with lib; with types; {
		enable = mkEnableOption "wg";
		endpoint = mkOption { type = str; };
		tunnel = mkEnableOption "is tunnel";
		address = mkOption { type = str; };
		allowedIPs = mkOption { type = nullOr (listOf str); };
		keys = {
			privateFile = mkOption { type = str; };
			public = mkOption { type = str; };
			preshared = mkOption { type = nullOr str; };
		};
	};
	config = let cfg = config.wg;
	in lib.mkIf cfg.enable {
		networking.wireguard.enable = true;
		networking.wg-quick.interfaces = {
			wg0 = {
				address = [ cfg.address ];

				privateKeyFile = cfg.keys.privateFile;

				extraOptions = if cfg.tunnel then {FwMark = "0xca6c";} else {};

				peers = [
					{ 
						publicKey = cfg.keys.public;
						presharedKey = cfg.keys.preshared;
						allowedIPs = 
							if cfg.tunnel
								then [ "0.0.0.0/0" ]
								else cfg.allowedIPs;
						endpoint = cfg.endpoint;
						persistentKeepalive = 25;
					}
				];
			};
		};
	};
}
