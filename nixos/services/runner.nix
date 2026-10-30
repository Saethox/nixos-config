{
  config,
  lib,
  pkgs,
  outputs,
  ...
}: let
  cfg = config.modules.services.runner;

  work = "/var/lib/runner";
  binPath = lib.makeBinPath ((with pkgs; [rsync gcc rustup uv]) ++ (with pkgs.rolling; [devenv])) + ":/run/current-system/sw/bin";
  sandbox = pkgs.writeShellScript "runner-sandbox" ''
    exec ${pkgs.bubblewrap}/bin/bwrap \
      --unshare-user --unshare-ipc --unshare-uts --unshare-cgroup \
      --ro-bind /nix/store /nix/store \
      --ro-bind /run/current-system/sw /run/current-system/sw \
      --ro-bind /etc/resolv.conf /etc/resolv.conf \
      --proc /proc \
      --dev /dev --tmpfs /tmp \
      --bind ${work} ${work} --chdir ${work} \
      --symlink ${pkgs.coreutils}/bin/env /usr/bin/env \
      --symlink ${pkgs.bash}/bin/sh /bin/sh \
      --symlink ${config.environment.variables.NIX_LD} /lib64/ld-linux-x86-64.so.2 \
      --setenv NIX_LD ${config.environment.variables.NIX_LD} \
      --setenv NIX_LD_LIBRARY_PATH ${config.environment.variables.NIX_LD_LIBRARY_PATH} \
      --setenv HOME ${work} --setenv CARGO_HOME ${work}/.cargo --setenv RUSTUP_HOME ${work}/.rustup \
      --setenv UV_CACHE_DIR ${work}/.cache/uv \
      --setenv UV_PYTHON_INSTALL_DIR ${work}/.python \
      --setenv UV_PYTHON_PREFERENCE only-managed \
      --setenv PATH ${binPath} \
      --setenv SSL_CERT_FILE ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt \
      -- ${pkgs.bash}/bin/bash -c "''${SSH_ORIGINAL_COMMAND:-true}"
  '';
in {
  options.modules.services.runner.enable = lib.mkEnableOption "task runner";

  config = lib.mkIf cfg.enable {
    modules.services.ssh.enable = true;

    services.avahi = {
      enable = true;
      openFirewall = true;
      publish = {
        enable = true;
        addresses = true;
      };
    };

    users.users.runner = {
      isNormalUser = true; # not in wheel, no password
      home = work;
      createHome = true;
      homeMode = "700";
      openssh.authorizedKeys.keys = [
        ''restrict,command="${sandbox}" ${outputs.constants.pubkeys.ceres}''
      ];
    };
  };
}
