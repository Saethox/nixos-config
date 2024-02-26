{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.latex;
in {
  options.modules.dev.latex.enable = lib.mkEnableOption "latex";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs.unstable; [
      (texlive.combine {inherit (texlive) scheme-full libertine inconsolata biblatex newtx;})
    ];
  };
}
