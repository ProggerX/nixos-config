{
  config,
  pkgs,
  ...
}: {
  programs.fish.enable = false;
  programs.fish.interactiveShellInit = ''
    set fish_greeting
    direnv hook fish | source
    zoxide init fish --cmd cd | source
    fish_vi_key_bindings
  '';
  programs.fish.shellAliases = {
    q = "exit";
    nput = "ssh -p9990 bald.su";
    nget = "ssh -p9991 bald.su";
    update = "sudo nixos-rebuild switch --flake /home/proggerx/nixos-config#pocket-os";
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
    gin = "go install";
    gbld = "go build";
    grun = "go run .";
  };
}
