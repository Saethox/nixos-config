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
        vesktop # Alternate client for Discord with Vencord built-in
        prismlauncher # Free, open source launcher for Minecraft
      ])
      ++ (with pkgs.unstable; [
        mullvad-vpn # VPN (requires `services.mullvad-vpn`)
        bazecor # Graphical configurator for Dygma Products
      ]);
  };
}
