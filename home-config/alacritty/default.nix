{ builtins, config, pkgs, ... }:
{
    programs.alacritty.enable = true;
    programs.alacritty.settings = { import = [ "/etc/nixos/home-config/alacritty/catppuccin-mocha.toml" ]; window = {opacity = 0.8;}; font = {size = 17; normal = {family = "JetBrainsMono Nerd Font";};};};
}
