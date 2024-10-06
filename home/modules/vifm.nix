{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    programs.vifm = {
      enable = lib.mkEnableOption "Enable vifm - vi-like file manager";
      package = lib.mkPackageOption pkgs "vifm" { default = [ "vifm-full" ]; };
      settings = lib.mkOption {
        type = with lib.types; nullOr (either path lines);
        default = null;
        description = "vifmrc";
      };
    };
  };
  config =
    let
      cfg = config.programs.vifm;
    in
    lib.mkIf cfg.enable {
      home.packages = [ cfg.package ];
      xdg.configFile."vifm/vifmrc" = lib.mkIf (cfg.settings != null) (
        if builtins.isPath cfg.settings then
          {
            source = cfg.settings;
          }
        else
          {
            text = cfg.settings;
          }
      );
    };
}
