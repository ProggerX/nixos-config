{ pkgs, sys, lib, ... }: {
    wayland.windowManager.river = {
        enable = false;
        settings = import ./settings.nix { inherit pkgs; inherit sys; inherit lib; };
    };
}
