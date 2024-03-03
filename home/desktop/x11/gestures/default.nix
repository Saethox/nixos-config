{
  config,
  lib,
  ...
}: let
  cfg = config.modules.desktop.x11.gestures;
in {
  options.modules.desktop.x11.gestures.enable = lib.mkEnableOption "x11 touchpad gestures";

  config = lib.mkIf cfg.enable {
    xdg.configFile."touchegg/touchegg.conf".source = ./touchegg.xml;
  };
}
