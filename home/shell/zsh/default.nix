{ ... }:
{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
    
        initExtra = ''
            setopt completealiases
            bindkey -v '^?' backward-delete-char
        '';

        shellAliases = {
            dploy = "deploy -s";
            update = "nh os switch /home/proggerx/Nix/nixos-config";
            q = "exit";
            cls = "clear";
            cat = "bat";
            o = "nvim";
            ed = "vim";
            c = "clear";
            g = "git";
            ls = "eza --icons";
            lg = "lazygit";
            l = "ls -a -F";
            gin = "go install";
            gbld = "go build";
            grun = "go run .";
            nput = "ssh -p9990 bald.su";
            nget = "ssh -p9991 bald.su";
            ssh = "TERM=xterm-256color ssh";
        };
    };
}
