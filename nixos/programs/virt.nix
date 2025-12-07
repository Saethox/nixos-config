{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.programs.virt;
in {
  options.modules.programs.virt.enable = lib.mkEnableOption "virt";

  config = lib.mkIf cfg.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
        };
      };
      spiceUSBRedirection.enable = true;
    };

    environment.systemPackages = with pkgs; [
      spice
      spice-gtk
      spice-protocol
      virt-viewer
      #virtio-win
      #win-spice
    ];
    programs.virt-manager.enable = true;
  };
}
