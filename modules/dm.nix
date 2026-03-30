{pkgs, ...}: let
  compositor = "sway";
  user = "proggerx";
in {
  boot.kernelParams = ["console=tty1"];
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
