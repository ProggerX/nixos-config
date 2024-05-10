{pkgs, config, ...}:
{
home.pointerCursor = 
       {
          gtk.enable = true;
          x11.enable = true;
          name = "Catppuccin-Mocha-Lavender-Cursors";
          size = 35;
          package = pkgs.catppuccin-cursors.mochaLavender;
   };
}
