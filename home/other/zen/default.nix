{ pkgs, inputs, ... }:
{
    home.packages = [ inputs.zen-browser.packages.${pkgs.system}.default ];
}
