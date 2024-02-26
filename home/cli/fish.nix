{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.cli.fish;
in {
  options.modules.cli.fish.enable = lib.mkEnableOption "fish with plugins";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs.fishPlugins; [
      done # Notifications
      forgit # Git additions
      fzf-fish # Key bindings for fzf
      grc # Colorize using grc
      autopair # Matching pairs
      puffer # Text expansion
    ];

    programs.fish = {
      enable = true;
      functions = {
        # Disable greeting.
        fish_greeting = "";
      };
      interactiveShellInit = ''
        zoxide init fish | source
      '';
    };
  };
}
