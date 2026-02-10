{ pkgs, ... }:
{
	home.packages = [
		(pkgs.writeShellScriptBin "cwp" ''
			chosen=$(
				find $HOME/wallpapers/ -type f -print0 \
				| xargs -0 file --mime-type \
				| grep 'image/' \
				| cut -d ':' -f 1 \
				| sed "s|$HOME/wallpapers/||" \
				| ${pkgs.rofi}/bin/rofi -dmenu -p "Select wallpaper" 
			)
			[ $? -eq 0 ] \
				&& (i=$(pidof swaybg)
				${pkgs.swaybg}/bin/swaybg -m fill\
				  -i $HOME/wallpapers/$chosen &
				sleep 2
				kill $i
				disown
				)
		'')
	];
	home.file.wallpapers.source = ../../../stylix/wallpapers;
}
