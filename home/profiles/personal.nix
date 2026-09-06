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
        qbittorrent # Featureful free software BitTorrent client
        mullvad-vpn # VPN (requires `services.mullvad-vpn`)
      ])
      ++ (with pkgs.unstable; [
        bazecor # Graphical configurator for Dygma Products
      ]);
  };
}
