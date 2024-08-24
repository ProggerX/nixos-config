{ inputs, ... }: {
    imports = [
        inputs.yandex-music.nixosModules.default
    ];
    programs.yandex-music.enable = true;
    programs.yandex-music.tray.enable = true;
}
