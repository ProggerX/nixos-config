{
  pkgs,
  sys,
  ...
}: {
  imports = [
    ./ncmpcpp
    ./tor-proxy
    ./zathura
  ];
  stylix.iconTheme = {
    enable = true;
    package = pkgs.gruvbox-plus-icons;
    dark = "Gruvbox-Plus-Dark";
    light = "Gruvbox-Plus-Light";
  };
  home.pointerCursor.hyprcursor.enable = true;
  services.mpdris2 = {
    enable = true;
    mpd = {
      host = "localhost";
      port = 6600;
      musicDirectory = "/home/proggerx/music";
    };
  };
  services.trayscale.enable = true;
}
