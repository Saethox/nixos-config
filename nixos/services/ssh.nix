{
  config,
  lib,
  ...
}: let
  cfg = config.modules.services.ssh;
in {
  options.modules.services.ssh.enable = lib.mkEnableOption "openssh server";

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        # Forbid root login through SSH.
        PermitRootLogin = "no";
        # Use keys only.
        PasswordAuthentication = false;
      };
    };
  };
}
