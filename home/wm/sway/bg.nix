{
  pkgs,
  lib,
  config,
  ...
}: let
  wpDir = "${../../../stylix/wallpapers}/";
  bgExe = "${pkgs.swaybg}/bin/swaybg";
  bgArgs = "-m fill -i";
in {
  options.bg.setDefault = lib.mkOption {
    default = "${bgExe} ${bgArgs} ${config.stylix.image}";
  };
  config.home.packages = [
    (pkgs.writeShellScriptBin "cwp" ''
      chosen=$(
      	find ${wpDir}/ -type f -print0 \
      	| xargs -0 file --mime-type \
      	| grep 'image/' \
      	| cut -d ':' -f 1 \
      	| sed "s|${wpDir}/||" \
      	| ${pkgs.rofi}/bin/rofi -dmenu -p "Select wallpaper"
      )
      [ $? -eq 0 ] \
      	&& (i=$(pidof ${bgExe})
      	${bgExe} ${bgArgs} ${wpDir}/$chosen &
      	sleep 2
      	kill $i
      	disown
      	)
    '')
  ];
}
