{ config, ... }: {
	networking.wireguard = {
		enable = true;
		interfaces = {
			wg0 = {
				ips = [ "10.7.0.6/24" ];

				listenPort = 51820;

				privateKeyFile = config.age.secrets.wg-server.path;

				peers = [
					{ 
						name = "me";
						publicKey = "eBynlYh1/1vwqD8KQ2PhwrPVUWnZ7dEoqrZ8iLyNVS0=";
						presharedKey = "30Rs/kPpjwK6JeIlOrZgvbOVZqdonaegNQs+dNN1W6M=";
						allowedIPs = [
							"10.7.0.0/24"
						];
						endpoint = "5.35.87.192:51820";
						persistentKeepalive = 25;
					}
				];
			};
		};
	};
}
