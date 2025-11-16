{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.python3;
in {
  options.modules.dev.python3.enable = lib.mkEnableOption "python3";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Latest stable Python with useful packages.
      (python3.withPackages (ps: with ps; ([ipython numpy pandas matplotlib seaborn])))
      uv # Dependency management
    ];
  };
}
