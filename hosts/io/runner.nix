{
  config,
  pkgs,
  lib,
  ...
}: let
  work = "/var/lib/runner";
  binPath =
    lib.makeBinPath [pkgs.bash pkgs.rsync pkgs.gcc] + ":/run/current-system/sw/bin";
  sandbox = pkgs.writeShellScript "runner-sandbox" ''
    exec ${pkgs.bubblewrap}/bin/bwrap \
      --unshare-user --unshare-ipc --unshare-uts --unshare-cgroup \
      --ro-bind /nix/store /nix/store \
      --ro-bind /run/current-system/sw /run/current-system/sw \
      --ro-bind /etc/resolv.conf /etc/resolv.conf \
      --ro-bind /proc /proc --dev /dev --tmpfs /tmp \
      --bind ${work} ${work} --chdir ${work} \
      --symlink ${config.environment.variables.NIX_LD} /lib64/ld-linux-x86-64.so.2 \
      --setenv NIX_LD ${config.environment.variables.NIX_LD} \
      --setenv NIX_LD_LIBRARY_PATH ${config.environment.variables.NIX_LD_LIBRARY_PATH} \
      --setenv HOME ${work} --setenv CARGO_HOME ${work}/.cargo --setenv RUSTUP_HOME ${work}/.rustup \
      --setenv PATH ${binPath} \
      --setenv SSL_CERT_FILE ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt \
      -- ${pkgs.bash}/bin/bash -c "''${SSH_ORIGINAL_COMMAND:-true}"
  '';
in {
  users.users.runner = {
    isNormalUser = true; # not in wheel, no password
    home = work;
    createHome = true;
    homeMode = "700";
    openssh.authorizedKeys.keys = [
      ''restrict,command="${sandbox}" ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPVhCuZyCboaEPg83C3m7efgyhd+fx64RcEYBYV8vEKy runner''
    ];
  };
}
