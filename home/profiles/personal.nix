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
        prismlauncher # Free, open source launcher for Minecraft
      ])
      ++ (with pkgs.unstable; [
        mullvad-vpn # VPN (requires `services.mullvad-vpn`)
        bazecor # Graphical configurator for Dygma Products
        ckb-next # Driver and configuration tool for Corsair keyboards and mice
      ]);
  };
}
