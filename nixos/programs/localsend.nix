{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [53317];
    allowedUDPPorts = [53317];
  };
}
