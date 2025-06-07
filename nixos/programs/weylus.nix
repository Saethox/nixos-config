{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.programs.weylus;
in {
  options.modules.programs.weylus.enable = lib.mkEnableOption "weylus";

  config = lib.mkIf cfg.enable {
    programs.weylus = {
      enable = true;
      package = pkgs.rolling.weylus;
      users = ["joni"];
      openFirewall = true;
    };
  };
}
