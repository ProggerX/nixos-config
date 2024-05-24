{ config, ... }:
{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
	
		initExtra = ''
			eval "$(direnv hook fish)"
			zoxide init zsh --cmd cd | source
			gof
		'';

		shellAliases = {
			update = "sudo nixos-rebuild switch";
			q = "exit";
			cls = "clear";
			lt = "leetcode";
			cat = "bat";
			o = "vim";
			ed = "vim";
			c = "clear && gof";
			g = "git";
			ls = "eza --icons";
			lg = "lazygit";
			l = "ls -a -F";
			mail = "aerc";
			gin = "go install";
			gbld = "go build";
			grun = "go run .";
		};

		histSize = 10000;
		histFile = "${config.xdg.dataHome}/zsh/history";
	};
}
