{
  config,
  lib,
  ...
}: let
  cfg = config.modules.virtualization;
in {
  options.modules.virtualization.enable = lib.mkEnableOption "virtualization";

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;
    virtualisation.libvirtd.enable = true;
  };
}
