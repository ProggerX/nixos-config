{config, pkgs, ...}:
{
	wayland.windowManager.hyprland = {
		enable = true;
		extraConfig = ''

source=/etc/nixos/home-config/hyprland/mocha.conf

monitor=eDP-1,1920x1080@60,0x0,1
monitor=HDMI-A-1,1920x1080@144,0x0,1

exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
exec-once = wl-paste --watch cliphist store
exec-once = waybar
exec-once = wpaperd
exec-once = firefox-devedition
# exec-once = alacritty --class nchat --command nchat
exec-once = telegram-desktop
exec-once = /home/proggerx/.local/bin/dsc
exec-once = transmission-daemon -c ~/download-torrent/


input {
    kb_layout = us,ru
	kb_variant = 
    kb_model =
	kb_options = caps:escape, grp:win_space_toggle
    kb_rules =

    follow_mouse = 1

    touchpad {
        natural_scroll = no
    }

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
}



general {
    gaps_in = 5
    gaps_out = 10
    border_size = 5
    col.active_border = $lavender
    col.inactive_border = rgba(00000000)
    layout = dwindle
}

decoration {
    rounding = 15

    drop_shadow = no

    dim_inactive = 1
    dim_strength = 0.2
}


animations {
    enabled = yes

    bezier = cool, 0.64, 0.33, 0.44, 0.94 

    animation = windows, 1, 7, default, slide
    animation = border, 1, 10, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 4.5, cool
}




dwindle {
    pseudotile = yes
    preserve_split = yes
}

master {
    new_is_master = 1
}


gestures {
    workspace_swipe = off
}




$mainMod = SUPER

bind = $mainMod, C, killactive, 
bind = $mainMod SHIFT, L, exec, lockscreen
bind = $mainMod, O, pin
bind = $mainMod, f, togglefloating, 
bind = $mainMod, P, pseudo,
bind = ALT $mainMod, P, exec, power
bind = $mainMod, M, exit
bind = $mainMod, y, togglesplit,
bind = $mainMod, u, fullscreen,


bind = $mainMod, RETURN, exec, kitty
bind = $mainMod, E, exec, nemo
bind = ALT, SPACE, exec, wofi --show run
bind = $mainMod, R, exec, wofi --show drun
bind = $mainMod, V, exec, cliphist list | wofi -dmenu | cliphist decode | wl-copy

bind = , PRINT, exec, grim -g"$(slurp)" - | wl-copy
bind = $mainMod, I, exec, grim -g"$(slurp)" -l 0 /home/proggerx/screen.png
bind = CTRL, PRINT, exec, rm -rf /home/proggerx/screen-record.mp4 && wf-recorder -g"$(slurp)" --file ~/screen-record.mp4
bind = CTRL SHIFT, PRINT, exec, pkill wf-recorder

bind = $mainMod, h, movefocus, l
bind = $mainMod, l, movefocus, r
bind = $mainMod, k, movefocus, u
bind = $mainMod, j, movefocus, d

bind = $mainMod CTRL SHIFT, h, movewindow, l
bind = $mainMod CTRL SHIFT, l, movewindow, r
bind = $mainMod CTRL SHIFT, k, movewindow, u
bind = $mainMod CTRL SHIFT, j, movewindow, d

bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Ресайз
bind = $mainMod CTRL, h, resizeactive,-50 0
bind = $mainMod CTRL, l, resizeactive,50 0
bind = $mainMod CTRL, k, resizeactive,0 -50
bind = $mainMod CTRL, j, resizeactive,0 50

bind = $mainMod CTRL, p, exec, powermenu


windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
windowrulev2 = noanim,class:^(xwaylandvideobridge)$
windowrulev2 = nofocus,class:^(xwaylandvideobridge)$
windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$

windowrulev2 = workspace 2,class:(firefox)
windowrulev2 = float,class:(showmethekey-gtk)
windowrulev2 = pin,class:(showmethekey-gtk)
windowrulev2 = workspace 4,class:(org.telegram.desktop)
windowrulev2 = workspace 3,class:(vesktop)
windowrulev2 = workspace 4,class:(nchat)

	'';
	};
}
