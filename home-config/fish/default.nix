{ config, pkgs, ... }:
{
	programs.fish.enable = true;
	programs.fish.interactiveShellInit = ''
		set fish_greeting
		eval "$(direnv hook fish)"
		zoxide init fish --cmd cd | source
        fish_vi_key_bindings
		gof
	'';
	programs.fish.shellAliases = {
		q = "exit";
		rebuild = "sudo nixos-rebuild switch";
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
}
