{ sys, pkgs, ... }: {
	services.cliphist.enable = true;
	services.hyprsunset.enable = true;
	wayland.windowManager.hyprland = {
		enable = true;
		settings = {
			env = [
				"LIBVA_DRIVER_NAME,nvidia;"
				"XDG_SESSION_TYPE,wayland;"
				"GBM_BACKEND,nvidia-drm;"
				"__GLX_VENDOR_LIBRARY_NAME,nvidia;"
			];

			cursor.no_hardware_cursors = true;
			
			monitor= [
				"eDP-1,1920x1080@60,0x0,1"
				"HDMI-A-1,1920x1080@144,0x0,1"
			];

			debug.damage_tracking = false;
			
			exec-once = [
				"firefox-nightly"
				"telegram-desktop"
				"sshfs 10.7.0.6:/music /home/proggerx/music"
				"easyeffects --gapplication-service"
				"${pkgs.networkmanagerapplet}/bin/nm-applet"
				"${pkgs.dissent}/bin/dissent"
			] ++ (if sys.isLaptop then [ "iio-hyprland" ] else [ ]);
			
			input = {
				kb_layout = "us,ru";
				kb_variant = "";
				kb_model = "";
				kb_options = "caps:escape, grp:win_space_toggle";
				kb_rules = "";
			
				follow_mouse = 1;
				scroll_method = (if sys.isLaptop then "on_button_down" else "2fg");
			
				touchpad.natural_scroll = false;
			
				sensitivity = 0;
			};
			
			general = {
				gaps_in = 5;
				gaps_out = 10;
				border_size = 2;
				layout = "master";
			};

			master.new_status = "master";
			
			decoration = {
				rounding = 10;
				dim_inactive = 0;
				dim_strength = 0.2;
			};
			
			"decoration:blur".enabled = false;
			"decoration:shadow".enabled = false;

			animations.enabled = false;
			
			gestures.workspace_swipe = true;
			gestures.workspace_swipe_touch = true;
			
			"$mainMod" = "SUPER";
			
			bind = [
				"$mainMod, C, killactive, "
				"$mainMod SHIFT, L, exec, hyprlock"
				"$mainMod, O, pin"
				"$mainMod, f, togglefloating," 
				"$mainMod, P, pseudo,"
				"ALT $mainMod, P, exec, power"
				"$mainMod, M, layoutmsg, swapwithmaster"
				"SHIFT $mainMod, M, layoutmsg, addmaster"
				"CTRL $mainMod, M, layoutmsg, removemaster"
				"$mainMod, y, togglesplit,"
				"$mainMod, u, fullscreen,"
				"$mainMod, TAB, exec, rofi -show window"
				
				
				"$mainMod, RETURN, exec, kitty"
				"$mainMod, E, exec, kitty vifm"
				"ALT, SPACE, exec, rofi -show run"
				"$mainMod, R, exec, rofi -show drun"
				"$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
				
				'', PRINT, exec, grim -g"$(slurp)" - | wl-copy''
				''$mainMod, I, exec, grim -g"$(slurp)" -l 0 /home/proggerx/screen.png''
				
				"$mainMod, h, layoutmsg, mfact -0.08"
				"$mainMod, l, layoutmsg, mfact +0.08"
				"$mainMod, j, layoutmsg, cyclenext"
				"$mainMod, k, layoutmsg, cycleprev"
				"$mainMod SHIFT, j, layoutmsg, swapnext"
				"$mainMod SHIFT, k, layoutmsg, swapprev"
				
				"$mainMod, 1, workspace, 1"
				"$mainMod, 2, workspace, 2"
				"$mainMod, 3, workspace, 3"
				"$mainMod, 4, workspace, 4"
				"$mainMod, 5, workspace, 5"
				"$mainMod, 6, workspace, 6"
				"$mainMod, 7, workspace, 7"
				"$mainMod, 8, workspace, 8"
				"$mainMod, 9, workspace, 9"
				"$mainMod, 0, workspace, 10"
				
				"$mainMod SHIFT, 1, movetoworkspace, 1"
				"$mainMod SHIFT, 2, movetoworkspace, 2"
				"$mainMod SHIFT, 3, movetoworkspace, 3"
				"$mainMod SHIFT, 4, movetoworkspace, 4"
				"$mainMod SHIFT, 5, movetoworkspace, 5"
				"$mainMod SHIFT, 6, movetoworkspace, 6"
				"$mainMod SHIFT, 7, movetoworkspace, 7"
				"$mainMod SHIFT, 8, movetoworkspace, 8"
				"$mainMod SHIFT, 9, movetoworkspace, 9"
				"$mainMod SHIFT, 0, movetoworkspace, 10"
				
				"$mainMod, mouse_down, workspace, e+1"
				"$mainMod, mouse_up, workspace, e-1"

				"$mainMod CTRL, h, resizeactive,-50 0"
				"$mainMod CTRL, l, resizeactive,50 0"
				"$mainMod CTRL, k, resizeactive,0 -50"
				"$mainMod CTRL, j, resizeactive,0 50"
			];
			
			bindm = [
				"$mainMod, mouse:272, movewindow"
				"$mainMod, mouse:273, resizewindow"
			];
			
			windowrulev2 = [
				"opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
				"noanim,class:^(xwaylandvideobridge)$"
				"nofocus,class:^(xwaylandvideobridge)$"
				"noinitialfocus,class:^(xwaylandvideobridge)$"
				"workspace 2,class:(firefox-nightly)"
				"float,class:(showmethekey-gtk)"
				"float,class:(Tk)"
				"pin,class:(showmethekey-gtk)"
				"workspace 4,class:(org.telegram.desktop)"
				"workspace 3,class:(vesktop)"
				"workspace 3,class:(so.libdb.dissent)"
				"workspace 4,class:(nchat)"
				"workspace 10,class:(Spotify)"
			];
		};
	};
}
