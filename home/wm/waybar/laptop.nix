{ lib, sys, ... }: 
lib.mkIf sys.isLaptop {
	programs.waybar.settings.bar.modules-right = lib.mkForce ["tray" "cpu" "memory" "custom/pipewire" "custom/brightness" "custom/battery" "sway/language" "clock"];
	programs.waybar.settings.bar.modules-center = lib.mkForce ["custom/spotify"];
}
