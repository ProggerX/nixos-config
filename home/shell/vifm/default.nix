{ pkgs, ... }: {
    home.packages = [ pkgs.vifm-full ];
    xdg.configFile."vifm/vifmrc".text = ''
        highlight clear
        
        highlight Border	cterm=none	ctermfg=235	ctermbg=default
        
        highlight TopLine	cterm=none	ctermfg=214	ctermbg=235
        highlight TopLineSel	cterm=bold	ctermfg=214	ctermbg=237
        
        highlight Win		cterm=none	ctermfg=223	ctermbg=default
        "highlight OtherWin  cterm=none	ctermfg=223	ctermbg=236
        highlight Directory	cterm=bold	ctermfg=109	ctermbg=default
        highlight CurrLine	cterm=bold,inverse	ctermfg=default	ctermbg=default
        highlight OtherLine	cterm=bold	ctermfg=default	ctermbg=235
        highlight Selected	cterm=none	ctermfg=223	ctermbg=237
        
        highlight JobLine	cterm=bold	ctermfg=116	ctermbg=238
        highlight StatusLine	cterm=bold	ctermfg=144	ctermbg=236
        highlight ErrorMsg	cterm=bold	ctermfg=167	ctermbg=default
        highlight WildMenu	cterm=bold	ctermfg=235	ctermbg=144
        highlight CmdLine	cterm=none	ctermfg=223	ctermbg=default
        
        highlight Executable	cterm=bold	ctermfg=142	ctermbg=default
        highlight Link		cterm=none	ctermfg=132	ctermbg=default
        highlight BrokenLink	cterm=bold	ctermfg=167	ctermbg=default
        highlight Device	cterm=none,standout	ctermfg=214	ctermbg=default
        highlight Fifo		cterm=none	ctermfg=172	ctermbg=default
        highlight Socket	cterm=bold	ctermfg=223	ctermbg=default

        set vicmd=nvim
        set sort=+iname
        filetype *.png,*.jpg,*.webp swayimg
        filetype *.pdf zathura
        filetype *.mp4,*.mkv,*.gif,*.mp3,*.flac mpv
        filetype *.docx,*.pptx,*.xlsx,*.odp,*.odt,*.ods soffice
        filetype *.tar.* mkdir -p %c-dir && cd %c-dir && tar -xf ../%c
        filetype *.zip mkdir -p %c-dir && cd %c-dir && unzip ../%c
    '';
}
