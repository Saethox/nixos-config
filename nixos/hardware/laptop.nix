{
  config,
  lib,
  ...
}: let
  cfg = config.modules.hardware.laptop;
in {
  options.modules.hardware.laptop.enable = lib.mkEnableOption "laptop settings";

  config = lib.mkIf cfg.enable {
    services.power-profiles-daemon.enable = lib.mkForce false;
    services.tlp.enable = true;
    services.thermald.enable = true;
  };
}
