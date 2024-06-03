{ pkgs, inputs, ... }:
let system = "x86_64-linux";
newpkgs = import inputs.newpkgs { inherit system; };
in {
    home.packages = with pkgs; [
		fasole
		lutris
		musikcube
		ytmdl
		xournalpp
		mindustry-wayland
		comma
		aseprite
		wineWowPackages.full
		wails
		godot_4
		freecad
		easyeffects
		newpkgs.telegram-desktop
		restish
		xorg.libX11
		ffmpeg
		lazydocker
		mpv
		typst
		typst-lsp
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
		newt
		tgpt
		kate
		codeium
		ncdu
		youtube-dl
		cmus
		cmusfm
		silicon
		cpplint
		openboard
		steamPackages.steamcmd
		leetcode-cli
		speedcrunch
		cinnamon.nemo
		tor-browser
		logiops
		steam-tui
		tea
		floorp-unwrapped
    	neofetch
		prismlauncher
		bc
		arduino
		ani-cli
		gimp
		tor-browser
		openjdk17-bootstrap
		osu-lazer-bin
		filelight
		xwaylandvideobridge
		alsa-utils
		toilet figlet
		cowsay
		xsnow
		glib
		wf-recorder
		translate-shell
		gnome.cheese
		github-cli
		wego
		mono
		fswatch
		asciinema
		asciinema-agg
		zathura
		brightnessctl
		transmission
		lynx
		chromium
		ventoy
		file
		ueberzug
		minesweep-rs
		element
		viu
		nodePackages.pyright
		just
		tmux
		# gdb
		ripgrep
		git
		lazygit
    	go
		bear
		vitetris
		tty-clock
		zoom-us
		fpc
    	tree
    	btop
		cava
		showmethekey
		element-desktop
		jq
		ccls
		nixd
		glab
		pulseaudio
		grim
		slurp
		flutter
		wl-clipboard cliphist
		waybar
    	winetricks
		rpg-cli
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
    	vifm
    	pandoc
    	scrot
    	lua-language-server
    	tmux
    	obsidian
    	slurp
    	eza
    	python311
		newpkgs.vesktop
		gcc
		gnumake
    	nitch
    	direnv
    ];
}
