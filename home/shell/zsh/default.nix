{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      bindkey -v '^?' backward-delete-char
    '';

    shellAliases = {
      dploy = "deploy -s";
      update = "sudo nixos-rebuild switch --flake /home/proggerx/Nix/nixos-config";
      q = "exit";
      cls = "clear";
      cat = "bat";
      o = "nvim";
      ed = "vim";
      c = "clear";
      g = "git";
      f = "vifm";
      ls = "${pkgs.lsd}/bin/lsd";
      lg = "lazygit";
      l = "ls -aF";
      gin = "go install";
      gbld = "go build";
      grun = "go run .";
      nput = "ssh -p9990 bald.su";
      nget = "ssh -p9991 bald.su";
      ssh = "TERM=xterm-256color ssh";
    };
  };
}
