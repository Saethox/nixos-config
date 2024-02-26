{
  config,
  lib,
  ...
}: let
  cfg = config.modules.direnv;
in {
  options.modules.direnv.enable = lib.mkOption {
    default = false;
    example = true;
    description = "Enable direnv.";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
