{
  lib,
  pkgs,
  ...
}: {
  imports = [../pc/configuration.nix];
  networking.hostName = lib.mkForce "snd-lp";

  services.xserver.videoDrivers = ["intel"];

  services.thermald.enable = true;
  isLaptop = true;
}
