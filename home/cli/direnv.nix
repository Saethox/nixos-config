{
  config,
  lib,
  ...
}: let
  cfg = config.modules.cli.direnv;
in {
  options.modules.cli.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
