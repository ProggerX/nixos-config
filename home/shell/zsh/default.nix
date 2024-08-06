{ ... }:
{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
	
		initExtra = ''
			export TERM=xterm-256color
			setopt completealiases
			bindkey -v '^?' backward-delete-char
			eval "$(direnv hook zsh)"
			eval "$(zoxide init zsh --cmd cd)"
		'';

		shellAliases = {
			ms = "musikcube";
			dploy = "deploy -s";
			dl = "ytmdl";
			update = "nh os switch /home/proggerx/nixos-config";
			q = "exit";
			cls = "clear";
			lt = "leetcode";
			cat = "bat";
			o = "nvim";
			ed = "vim";
			c = "clear";
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
