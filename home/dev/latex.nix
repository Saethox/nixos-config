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
      (texliveSmall.withPackages (
        ps:
          with ps; [
            scheme-full
            libertine
            inconsolata
            biblatex
            newtx
          ]
      ))
    ];
  };
}
