{
  config,
  lib,
  ...
}: let
  cfg = config.modules.services.mullvad;
in {
  options.modules.services.mullvad.enable = lib.mkEnableOption "Mullvad VPN";

  config = lib.mkIf cfg.enable {
    services.mullvad-vpn.enable = true;

    # https://discourse.nixos.org/t/connected-to-mullvadvpn-but-no-internet-connection/35803/13
    networking.resolvconf.extraConfig = ''
      dynamic_order='tap[0-9]* tun[0-9]* vpn vpn[0-9]* wg* wg[0-9]* ppp[0-9]* ippp[0-9]*'
    '';

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
        1401
      ];
      allowedUDPPorts = [
        53
        1400
      ];
      allowedUDPPortRanges = [
        {
          from = 1194;
          to = 1197;
        }
        {
          from = 1300;
          to = 1303;
        }
      ];
    };
  };
}
