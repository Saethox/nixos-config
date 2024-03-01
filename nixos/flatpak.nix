{
  config,
  lib,
  ...
}: let
  cfg = config.modules.flatpak;
in {
  options.modules.flatpak.enable = lib.mkEnableOption "flatpak";

  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;
  };
}
