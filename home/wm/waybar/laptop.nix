{ lib, sys, ... }: 
lib.mkIf sys.isLaptop {
    programs.waybar.settings.bar.modules-right = lib.mkForce [ "tray" "custom/pipewire" "custom/brightness" "custom/battery" "sway/language" "clock" ];
}
