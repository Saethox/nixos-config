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
      (python3.withPackages (ps: with ps; ([ipython numpy pandas matplotlib seaborn] ++ lib.lists.optional config.modules.dev.latex.enable pygments)))
      poetry # Dependency management
      # TODO: Figure out how to add this.
      # (builtins.getFlake "github:GuillaumeDesforges/fix-python/c9c8e8a439e0c985d0c5cea757d806837cf322f1") # Path .venv with `fix-python`
    ];
  };
}
