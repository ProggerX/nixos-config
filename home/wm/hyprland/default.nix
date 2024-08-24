{ ... }:
{
    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            env = [
                "LIBVA_DRIVER_NAME,nvidia;"
                "XDG_SESSION_TYPE,wayland;"
                "GBM_BACKEND,nvidia-drm;"
                "__GLX_VENDOR_LIBRARY_NAME,nvidia;"
            ];

            cursor = {
                no_hardware_cursors = true;
            };
            
            monitor= [
                "eDP-1,1920x1080@60,0x0,1"
                "HDMI-A-1,1920x1080@144,0x0,1"
            ];
            
            exec-once = [
                "wl-paste --watch cliphist store"
                "waybar"
                "spotify"
                # "firefox-devedition"
                "brave"
                "telegram-desktop"
                "vesktop"
            ];
            
            input = {
                kb_layout = "us,ru";
                kb_variant = "";
                kb_model = "";
                kb_options = "caps:escape, grp:win_space_toggle";
                kb_rules = "";
            
                follow_mouse = 1;
            
                touchpad = {
                    natural_scroll = false;
                };
            
                sensitivity = 0;
            };
            
            general = {
                gaps_in = 5;
                gaps_out = 10;
                border_size = 2;
                layout = "dwindle";
            };
            
            decoration = {
                rounding = 10;
            
                drop_shadow = "no";
            
                dim_inactive = 1;
                dim_strength = 0.2;
            };
            
            "decoration:blur" = {
                enabled = false;
            };

            animations = {
                enabled = true;
            
                bezier = "cool, 0.64, 0.33, 0.44, 0.94";
            
                animation = [
                    "windows, 1, 2, default, slide"
                    "border, 1, 2, default"
                    "fade, 1, 2, default"
                    "workspaces, 1, 2, cool"
                ];
            };
            
            dwindle =  {
                pseudotile = true;
                preserve_split = true;
            };
            
            gestures = {
                workspace_swipe = false;
            };
            
            "$mainMod" = "SUPER";
            
            bind = [
                "$mainMod, C, killactive, "
                "$mainMod SHIFT, L, exec, hyprlock"
                "$mainMod, O, pin"
                "$mainMod, f, togglefloating," 
                "$mainMod, P, pseudo,"
                "ALT $mainMod, P, exec, power"
                "$mainMod, M, exit"
                "$mainMod, y, togglesplit,"
                "$mainMod, u, fullscreen,"
                
                
                "$mainMod, RETURN, exec, kitty"
                "$mainMod, E, exec, nemo"
                "ALT, SPACE, exec, rofi -show run"
                "$mainMod, R, exec, rofi -show drun"
                "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
                
                '', PRINT, exec, grim -g"$(slurp)" - | wl-copy''
                ''$mainMod, I, exec, grim -g"$(slurp)" -l 0 /home/proggerx/screen.png''
                ''CTRL, PRINT, exec, rm -rf /home/proggerx/screen-record.mp4 && wf-recorder -g"$(slurp)" --file ~/screen-record.mp4''
                "CTRL SHIFT, PRINT, exec, pkill wf-recorder"
                
                "$mainMod, h, movefocus, l"
                "$mainMod, l, movefocus, r"
                "$mainMod, k, movefocus, u"
                "$mainMod, j, movefocus, d"
                
                "$mainMod CTRL SHIFT, h, movewindow, l"
                "$mainMod CTRL SHIFT, l, movewindow, r"
                "$mainMod CTRL SHIFT, k, movewindow, u"
                "$mainMod CTRL SHIFT, j, movewindow, d"
                
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
                # "workspace 2,class:(firefox)"
                "workspace 2,class:(Brave-browser)"
                "float,class:(showmethekey-gtk)"
                "float,class:(Tk)"
                "pin,class:(showmethekey-gtk)"
                "workspace 4,class:(org.telegram.desktop)"
                "workspace 3,class:(vesktop)"
                "workspace 4,class:(nchat)"
                "workspace 10,class:(YandexMusic)"
                "workspace 10,class:(Spotify)"    
            ];
        };
    };
}
