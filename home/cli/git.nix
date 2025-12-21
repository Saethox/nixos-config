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
        settings = {
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
          settings.user.name = "Saethox";
          settings.user.email = "joni.htruw@gmail.com";
        };
        "work" = {
          settings.user.name = "Jonathan Wurth";
          settings.user.email = "jonathan.wurth@uni-a.de";
        };
      }
      ."${cfg.user}";
  };
}
