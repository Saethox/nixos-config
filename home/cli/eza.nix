{
  config,
  lib,
  ...
}: let
  cfg = config.modules.cli.eza;
in {
  options.modules.cli.eza.enable = lib.mkEnableOption "eza with ls replacement";

  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;
      # Replace `ls` with `eza`.
      enableAliases = true;
      icons = true;
      git = true;
    };
  };
}
