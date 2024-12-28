{ ... }: {
    xdg.configFile."neofetch/config.conf".source = ./config.conf;
    xdg.configFile."neofetch/logo.txt" = {
        source = ./logo.txt;
        executable = true;
        recursive = true;
    };
}
