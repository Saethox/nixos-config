{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.programs.steam;
in {
  options.modules.programs.steam.enable = lib.mkEnableOption "steam";

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
    };

    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [mangohud lutris bottles heroic];
  };
}
