{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      # Mullvad VPN
      80
      443
      1401
    ];
    allowedTCPPortRanges = [
      # KDE Connect
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPorts = [
      # Mullvad VPN
      53
      1400
    ];
    allowedUDPPortRanges = [
      # KDE Connect
      {
        from = 1714;
        to = 1764;
      }
      # Mullvad VPN
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
}
