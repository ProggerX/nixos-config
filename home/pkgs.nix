{ pkgs, inputs, system, ... }:
let unstable = import inputs.unstable { inherit system; }; in {
    home.packages = with pkgs; [
		apostrophe
		firefox-beta
		gamescope
		nicotine-plus
		fretboard
		haskellPackages.pointfree
		tree-sitter
		ollama
		marksman
		codeberg-cli
        inputs.pabc-nix.packages.${pkgs.system}.default
		codeblocks
		jetbrains.pycharm-community-bin
		typst
		tinymist
		texlab
		pandoc
        ghc
		(texlive.combine { inherit (texlive) scheme-tetex ucs cyrillic; })
		nodejs
        cf-tool
        haskellPackages.hoogle
		arduino
		arduino-cli
		zig
		zls
		arduino-language-server
        cassette
        haskell-language-server
        cabal-install
        stack
        tic-80
        cool-retro-term
        (dwarf-fortress-packages.dwarf-fortress-full.override {
            dfVersion = "0.47.05";
            enableDwarfTherapist = false;
        })
        tgpt
        neovide
        lutris
        neovim
        deploy-rs
        openvpn3
        swayimg
        element-desktop
        obs-studio
        fasole
        wmctrl
        typescript
        musikcube
        mindustry-wayland
        ags
        wineWowPackages.full
        wails
        restish
        ffmpeg
        lazydocker
        mpv
        clang-tools
        mpg123
        parted
        aalib
        exiftool
        fzf
        zoxide
        sshpass
        simplex-chat-desktop
        nchat
        ncdu
        openboard
        leetcode-cli
        speedcrunch
        nemo
        tor-browser
        neofetch
        prismlauncher
        bc
        gimp
        openjdk17-bootstrap
        osu-lazer-bin
        xwaylandvideobridge
        alsa-utils
        toilet figlet
        cowsay
        glib
        wf-recorder
        translate-shell
        github-cli
        mono
        fswatch
        zathura
        brightnessctl
        transmission_3
        chromium
        ventoy
        file
        ueberzug
        element
        viu
        pyright
        just
        tmux
        ripgrep
        git
        lazygit
        unstable.go
        bear
        vitetris
        tty-clock
        fpc
        tree
        btop
        cava
        showmethekey
        jq
        nixd
        pulseaudio
        grim
        slurp
        wl-clipboard cliphist
        waybar
        winetricks
        wireplumber
        libreoffice
        p7zip
        ldmtool
        python311Packages.pip
        timeshift
        sonic-pi
        slstatus
        zip
        unzip
        cmake
        pamixer
        gnupg
        pavucontrol
        xclip
        lldb
        lua-language-server
        tmux
        obsidian
        slurp
        eza
        python311
        unstable.vesktop
        gcc
        gnumake
        nitch
        direnv
    ];
}
