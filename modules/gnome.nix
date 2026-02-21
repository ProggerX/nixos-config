{pkgs, ...}: {
  programs.dconf.profiles.user.databases = [
    {
      lockAll = true;
      settings = {
        "org/gnome/desktop/input-sources" = {
          sources = "[('xkb', 'us'), ('xkb', 'ru')]";
          xkb-options = ["grp:win_space_toggle" "caps:escape"];
        };
        "org/gnome/shell" = {
          enabled-extensions = with pkgs.gnomeExtensions; [
            runcat.extensionUuid
            forge.extensionUuid
          ];
        };
      };
    }
  ];
}
