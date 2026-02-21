{ pkgs, config, ... }:
{
    stylix = {
        enable = true;
        cursor = {
            name = "idk-cursor";
            size = 35;
            package = pkgs.capitaine-cursors-themed.overrideAttrs (old:{
                installPhase = old.installPhase + "cp -r $out/share/icons/'Capitaine Cursors (Gruvbox)' $out/share/icons/idk-cursor";
            });
        };
        opacity = {
            terminal = 1.0;
            applications = 1.0;
        };
        fonts = rec {
            sizes = {
                terminal = (if config.isLaptop then 14 else 12);
            };
            serif = {
                package = pkgs.dejavu_fonts;
                name = "DejaVu Serif";
            };
            sansSerif = {
                package = pkgs.nerd-fonts.jetbrains-mono;
                name = "JetBrainsMono NF";
            };
            monospace = sansSerif;
            emoji = {
                package = pkgs.noto-fonts-color-emoji;
                name = "Noto Color Emoji";
            };
        };
        base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";
        image = ./wallpapers/oguri.png;
			# let color = "${config.lib.stylix.colors.base00}";
			# in import ./color.nix { inherit pkgs; col = "#${color}"; w = 1920; h = 1080; };
    };
}
