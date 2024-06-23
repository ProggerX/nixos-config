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
			if [ -z "$TMUX" ]; then
				exec tmux new -s $(date +%T) && exit;
			fi
		'';

		shellAliases = {
			ms = "musikcube";
			dl = "ytmdl";
			update = "sudo nixos-rebuild switch --flake /home/proggerx/nixos-config#pocket-os";
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
			nput = "ssh -p9990 bald.su";
			nget = "ssh -p9991 bald.su";
		};
	};
}
