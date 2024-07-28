{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.profiles.personal;
in {
  options.modules.profiles.personal.enable = lib.mkEnableOption "personal packages";

  config = lib.mkIf cfg.enable {
    home.packages =
      (with pkgs; [
        discord # All-in-one cross-platform voice and text chat
      ])
      ++ (with pkgs.unstable; [
        mullvad-vpn # VPN (requires `services.mullvad-vpn`)
        bazecor # Graphical configurator for Dygma Products
      ]);
  };
}
