systemctl --user set-environment XDG_CURRENT_DESKTOP=wlroots; systemctl --user import-environment WAYLAND_DISPLAY; systemctl --user start xdg-desktop-portal-wlr.service
kanshi -c /kanshi.cfg
