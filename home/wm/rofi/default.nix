{ pkgs, sys, ... }: {
	stylix.targets.rofi.enable = false;
	programs.rofi = {
		enable = true;
		package = pkgs.rofi-wayland;
		theme = with sys.lib.stylix.colors; let filename = "theme-rofi.rasi"; in "${pkgs.writeText filename ''
			* {
				bg0: #${base00};
				bg1: #${base01};
				grey0: #${base02};
				fg0: #${base05};

				blue: #${base0D};
				red: #${base08};
				orange: #${base09};
				green: #${base0B};
				bgStatusline3: #${base05};

				background-color: @bg0;
			}

			window {
				height: 600;
				width: 600;

				border: 1;
				border-radius: 10;
				border-color: @bgStatusline3;
			}

			mainbox {
				spacing: 0;
				children: [inputbar, message, listview];
			}

			inputbar {
				color: @fg0;
				padding: 14;
				background-color: @bg0;
			}

			message {
				padding: 10;
				background-color: @grey0;
			}

			listview {
				padding: 8;
				border-radius: 0 0 10 10;
				border: 2 2 2 2;
				border-color: @bg0;
				background-color: @bg0;
				dynamic: false;
			}

			textbox {
				text-color: @fg0;
				background-color: inherit;
			}

			error-message {
				border: 20 20 20 20;
			}

			entry, prompt, case-indicator {
				text-color: inherit;
			}

			prompt {
				margin: 0 10 0 0;
			}

			element {
				padding: 5;
				vertical-align: 0.5;
				border-radius: 10;
				background-color: @bg1;
			}

			element.selected.normal {
				background-color: @grey0;
			}

			element.alternate.normal {
				background-color: inherit;
			}

			element.normal.active, element.alternate.active {
				background-color: @orange;
			}

			element.selected.active {
				background-color: @green;
			}

			element.normal.urgent, element.alternate.urgent {
				background-color: @red;
			}

			element.selected.urgent {
				background-color: @blue;
			}

			element-text, element-icon {
				size: 40;
				margin: 0 10 0 0;
				vertical-align: 0.5;
				background-color: inherit;
				text-color: @fg0;
			}

			element-text .active, element-text .urgent {
				text-color: @bg0;
			}
		''}";
		extraConfig = {
			display-ssh = " ";
			display-run = " ";
			display-drun = " ";
			display-window = " ";
			display-combi = " ";
			show-icons = true;
		};
	};
}
