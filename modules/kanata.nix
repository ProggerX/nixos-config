{ ... }: {
	hardware.uinput.enable = true;
	services.kanata = {
		enable = true;
		keyboards.all.config = ''
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
