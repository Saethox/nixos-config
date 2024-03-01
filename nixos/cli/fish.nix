{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.cli.fish;
in {
  options.modules.cli.fish.enable = lib.mkEnableOption "fish";

  config = lib.mkIf cfg.enable {
    # Basic fish shell.
    programs.fish = {
      enable = true;
      vendor = {
        completions.enable = true;
        config.enable = true;
        functions.enable = true;
      };
      shellAliases = {
        to-clipboard = "xclip -selection c";
        from-clipboard = "xclip -o";
      };
    };

    # Use fish shell by default.
    users.defaultUserShell = pkgs.fish;
  };
}
