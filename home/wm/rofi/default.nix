{ pkgs, sys, ... }: {
	stylix.targets.rofi.enable = false;
	programs.rofi = {
		enable = true;
		theme = with sys.lib.stylix.colors; let filename = "theme-rofi.rasi"; in "${pkgs.writeText filename ''
			* {
			    bg-col:  #${base00};
			    bg-col-light: #${base01};
			    border-col: #${base05};
			    selected-col: #${base02};
			    blue: #${base0D};
			    fg-col: #${base05};
			    fg-col2: #${base05};
			    grey: #${base05};
			
			    width: 600;
			    font: "JetBrainsMono NF 14";
			}
			
			element-text, element-icon , mode-switcher {
			    background-color: inherit;
			    text-color:       inherit;
			}
			
			window {
			    height: 540px;
			    border: 0px;
			    border-color: @border-col;
			    background-color: @bg-col;
			    border-radius: 10px;
			}
			
			mainbox {
			    background-color: @bg-col;
			}
			
			inputbar {
			    children: [prompt,entry];
			    background-color: @bg-col;
			    border-radius: 5px;
			    padding: 2px;
			}
			
			prompt {
			    background-color: @blue;
			    padding: 6px;
			    text-color: @bg-col;
			    border-radius: 3px;
			    margin: 20px 0px 0px 20px;
			}
			
			textbox-prompt-colon {
			    expand: false;
			    str: ":";
			}
			
			entry {
			    padding: 6px;
			    margin: 20px 0px 0px 10px;
			    text-color: @fg-col;
			    background-color: @bg-col;
			}
			
			listview {
			    border: 0px 0px 0px;
			    padding: 6px 0px 0px;
			    margin: 10px 0px 0px 20px;
			    columns: 2;
			    lines: 5;
			    background-color: @bg-col;
			}
			
			element {
			    padding: 5px;
			    background-color: @bg-col;
			    text-color: @fg-col  ;
			    border-radius: 5px;
			}
			
			element-icon {
			    size: 25px;
			}
			
			element selected {
			    background-color:  @selected-col ;
			    text-color: @fg-col2  ;
			}
			
			mode-switcher {
			    spacing: 0;
			  }
			
			button {
			    padding: 10px;
			    background-color: @bg-col-light;
			    text-color: @grey;
			    vertical-align: 0.5;
			    horizontal-align: 0.5;
			}
			
			button selected {
			  background-color: @bg-col;
			  text-color: @blue;
			}
			
			message {
			    background-color: @bg-col-light;
			    margin: 2px;
			    padding: 2px;
			    border-radius: 5px;
			}
			
			textbox {
			    padding: 6px;
			    margin: 20px 0px 0px 20px;
			    text-color: @blue;
			    background-color: @bg-col-light;
			}
		''}";
		extraConfig = {
			show-icons = false;
    		modi = "run,drun,window";
    		terminal = "kitty";
    		drun-display-format = "{icon} {name}";
    		disable-history = false;
    		hide-scrollbar = true;
    		display-drun = "   Apps ";
    		display-run = "   Run ";
    		display-window = " 󰕰  Window ";
    		sidebar-mode = true;
		};
	};
}
