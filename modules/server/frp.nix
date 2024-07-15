{
	services.frp = {
		enable = true;
		role = "client";
		settings = {
			serverAddr = "5.35.87.192";
			serverPort = 7000;
			proxies = [
				{
					name = "server_http";
					type = "tcp";
					localIP = "127.0.0.1";
					localPort = 80;
					remotePort = 80;
				}
				{
					name = "server_https";
					type = "tcp";
					localIP = "127.0.0.1";
					localPort = 443;
					remotePort = 443;
				}
			];
		};
	};
}
