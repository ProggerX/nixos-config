{ ... }: {
	services.kanata = {
		enable = true;
		keyboards."*".config = ''
(defsrc
  caps
)

(defalias
  escctrl (tap-hold 100 100 esc lctl)
)

(deflayer base
  @escctrl
)
		'';
	};
}
