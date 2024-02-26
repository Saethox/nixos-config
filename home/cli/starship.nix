{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.starship;
in {
  options.modules.starship.enable = lib.mkOption {
    default = false;
    example = true;
    description = "Enable starship prompts.";
  };

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
