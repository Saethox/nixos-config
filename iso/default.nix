{
  inputs,
  outputs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
    ../nixos/cli
    ../nixos/locale.nix
    ../nixos/services/ssh.nix
  ];
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };
  nixpkgs = {
    overlays = builtins.attrValues inputs.self.overlays;
    config.allowUnfree = true;
    hostPlatform = "x86_64-linux";
  };

  modules.services.ssh.enable = true;
  modules.cli.common.enable = true;

  users.users.nixos.openssh.authorizedKeys.keys = builtins.attrValues outputs.constants.pubkeys;
}
