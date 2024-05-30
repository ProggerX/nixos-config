{ ... }:
{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
	
		initExtra = ''
			eval "$(direnv hook zsh)"
			eval "$(zoxide init zsh --cmd cd)"
			gof
		'';

		shellAliases = {
			ms = "musikcube";
			dl = "ytmdl";
			update = "sudo nixos-rebuild switch --flake /etc/nixos#pocket-os";
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
	};
}
