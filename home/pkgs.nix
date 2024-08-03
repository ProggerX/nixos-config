{ pkgs, ... }: {
    home.packages = with pkgs; [
		tic-80
		cool-retro-term
		(dwarf-fortress-packages.dwarf-fortress-full.override {
			dfVersion = "0.47.05";
		})
		neovide
		deploy-rs
		openvpn3
		swayimg
		element-desktop-wayland
		obs-studio
		fasole
		wmctrl
		typescript
		musikcube
		mindustry-wayland
		ags
		wineWowPackages.full
		wails
		easyeffects
		telegram-desktop
		restish
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
		ncdu
		openboard
		leetcode-cli
		speedcrunch
		cinnamon.nemo
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
    	go
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
    	vifm
    	lua-language-server
    	tmux
    	obsidian
    	slurp
    	eza
    	python311
		vesktop
		gcc
		gnumake
    	nitch
    	direnv
    ];
}
