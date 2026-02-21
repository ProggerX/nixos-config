{
  config,
  pkgs,
  ...
}: {
  programs.password-store.enable = true;
  programs.password-store.package = pkgs.pass.withExtensions (exts: [exts.pass-import]);
}
