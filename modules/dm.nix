{ pkgs, ... }:
{
    boot.kernelParams = [ "console=tty1" ];
    services.greetd = {
        enable = true;
        vt = 2;
        settings = {
            default_session = {
                command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland -r ";
                user = "greeter";
            };
        };
    };
}
