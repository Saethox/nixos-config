{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.cli.starship;
in {
  options.modules.cli.starship.enable = lib.mkEnableOption "starship";

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      package = pkgs.unstable.starship;
      enableFishIntegration = true;
      # Remove previous prompt for clarity.
      enableTransience = true;
    };
  };
}
