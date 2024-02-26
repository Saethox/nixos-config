{
  config,
  lib,
  ...
}: let
  cfg = config.modules.eza;
in {
  options.modules.eza.enable = lib.mkOption {
    default = false;
    example = true;
    description = "Enable eza and replace ls.";
  };

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
