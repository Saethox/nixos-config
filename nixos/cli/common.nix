{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wget
    curl
    neofetch
    micro
  ];
}