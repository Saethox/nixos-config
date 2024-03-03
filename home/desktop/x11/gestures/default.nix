{
  config,
  lib,
  ...
}: let
  cfg = config.modules.desktop.x11.plasma.gestures;
in {
  options.modules.desktop.x11.plasma.gestures.enable = lib.mkEnableOption "x11 plasma touchpad gestures";

  config = lib.mkIf cfg.enable {
    xdg.configFile."touchegg/touchegg.conf".source = ./touchegg.xml;
  };
}
