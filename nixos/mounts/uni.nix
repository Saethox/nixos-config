{pkgs, ...}: let
  # Requires `nixos-config` to be symlinked to `/etc/nixos`.
  credentials = /etc/nixos/secrets/smb;
  # Options prevent hanging on network split.
  options = [
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=60"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
    "user"
    "users"
    "vers=3.0"
    "uid=1000"
    "credentials=${credentials}"
  ];
in {
  # For mount.cifs, required unless domain name resolution is not needed.
  environment.systemPackages = [pkgs.cifs-utils];

  # Home drive.
  fileSystems."/mnt/share/uni-home" = {
    device = "//cfs-smb.rz.uni-augsburg.de/wurthjon";
    fsType = "cifs";
    inherit options;
  };

  # OC drive.
  fileSystems."/mnt/share/uni-oc" = {
    device = "//cfs-smb.rz.uni-augsburg.de/oc-m";
    fsType = "cifs";
    inherit options;
  };
}
