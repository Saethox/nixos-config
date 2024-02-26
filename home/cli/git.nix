{
  config,
  lib,
  ...
}: let
  cfg = config.modules.cli.git;
in {
  options.modules.cli.git = {
    enable = lib.mkEnableOption "git with config";
    user = lib.mkOption {
      default = "private";
      example = "private";
      type = lib.types.enum ["private" "work"];
      description = "Git user profile type";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git =
      {
        enable = true;
        # Enable Git Large File Storage.
        lfs.enable = true;
        extraConfig = {
          # Rebase by default on `git pull`.
          pull.rebase = true;
          github.user = "Saethox";
        };
        ignores = [
          ".idea"
          ".direnv"
          ".envrc"
        ];
      }
      // {
        "private" = {
          userName = "Saethox";
          userEmail = "joni.htruw@gmail.com";
        };
        "work" = {
          userName = "Jonathan Wurth";
          userEmail = "jonathan.wurth@uni-a.de";
        };
      }
      ."${cfg.user}";
  };
}
