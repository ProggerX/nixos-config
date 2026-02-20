{ config, ... }: {
	imports = [ ../wireguard.nix ];
	wg = {
		enable = true;
		endpoint = "5.35.87.192:51820";
		tunnel = true;
		# allowedIPs = [ "10.7.0.0/24" ];
		address = "10.7.0.6";
		keys = {
			public = "eBynlYh1/1vwqD8KQ2PhwrPVUWnZ7dEoqrZ8iLyNVS0=";
			privateFile = config.age.secrets.wg-server.path;
			preshared = "30Rs/kPpjwK6JeIlOrZgvbOVZqdonaegNQs+dNN1W6M=";
		};
	};
}
