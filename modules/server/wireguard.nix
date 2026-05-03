{config, ...}: {
  imports = [../wireguard.nix];
  wg = {
    enable = true;
    endpoint = "5.35.87.192:51821";
    tunnel = true;
    allowedIPs = [ "10.8.0.0/24" ];
    address = "10.8.0.6";
    keys = {
      public = "v1pNYxDeQAwCPG8/eOO3A0fZrxz/HiiBCu3n5v86TXg=";
      privateFile = config.age.secrets.wg-server.path;
      preshared = "30Rs/kPpjwK6JeIlOrZgvbOVZqdonaegNQs+dNN1W6M=";
    };
  };
}
