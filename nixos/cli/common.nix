{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.cli.common;
in {
  options.modules.cli.common.enable = lib.mkEnableOption "common cli tools";

  config = lib.mkIf cfg.enable {
    modules.cli.fish.enable = lib.mkDefault true;

    environment.systemPackages =
      (with pkgs; [
        # Fetch files from the internet.
        wget
        curl

        # ZIP archive tools.
        zip
        unzip

        xclip # Clipboard

        neofetch # Display system information
        micro # Text editor with mouse support
        just # Command runner
        htop # System monitor
      ])
      ++ (with pkgs.unstable; [
        lshw # Print hardware configuration
      ]);
  };
}
