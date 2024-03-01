{
  config,
  lib,
  ...
}: let
  cfg = config.modules.laptop;
in {
  options.modules.laptop.enable = lib.mkEnableOption "laptop settings";

  config = lib.mkIf cfg.enable {
    services.auto-cpufreq.enable = true;
    services.thermald.enable = true;
  };
}
