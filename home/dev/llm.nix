{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.modules.dev.llm;
in {
  options.modules.dev.llm.enable = lib.mkEnableOption "llm agents";

  config = lib.mkIf cfg.enable {
    home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      claude-code
      opencode2
      codex
    ] ++ [pkgs.nodejs];
  };
}
