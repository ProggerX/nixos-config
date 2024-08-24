{ ... }: {
    programs.starship = {
        enable = true;
        settings = {
            add_newline = true;
            format = ''$username in $hostname: $directory$git_branch $git_status$line_break$character'';
            hostname = {
                format = ''[$hostname]($style)'';
                ssh_only = false;
                style = "bold purple";
            };
            git_branch = {
                format = ''[$symbol$branch(:$remote_branch)]($style)'';
            };
            line_break.disabled = false;
            username = {
                show_always = true;
                format = ''[$user]($style)'';
            };
            character = {
                success_symbol = "[>](bold green)";
                error_symbol = "[x>](bold red)";
                vimcmd_symbol = "[v](bold blue)";
            };
        };
    };
}
