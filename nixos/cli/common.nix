{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Fetch files from the internet
    wget
    curl

    zip
    unzip

    neofetch # Display system information
    micro # Text editor with mouse support
    just # Command runner
    htop # System monitor
  ];
}
