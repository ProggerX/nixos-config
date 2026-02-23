{pkgs, ...}:
let compositor = "sway";
	user = "proggerx";
in {
  boot.kernelParams = ["console=tty2"];
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time -r --cmd '${compositor} &> /home/${user}/.${compositor}.log'";
        user = "greeter";
      };
    };
  };
}
