{
  services.mullvad-vpn.enable = true;
  # https://discourse.nixos.org/t/connected-to-mullvadvpn-but-no-internet-connection/35803/10
  # EDIT: Breaks DNS somehow.
  # networking.resolvconf.enable = false;
}
