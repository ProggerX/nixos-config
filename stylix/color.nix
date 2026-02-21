{
  col,
  h,
  w,
  pkgs,
}: "${
  pkgs.runCommand "color" {}
  ''mkdir $out && ${pkgs.imagemagick}/bin/magick convert -size ${toString w}x${toString h} xc:${col} $out/color.png''
}/color.png"
