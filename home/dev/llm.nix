{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.modules.dev.llm;
  llmpkgs = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in {
  options.modules.dev.llm.enable = lib.mkEnableOption "llm agents";

  config = lib.mkIf cfg.enable {
    home.packages = with llmpkgs;
      [
        claude-code
        opencode2
        codex
      ]
      ++ [pkgs.nodejs pkgs.bun];

    home.sessionVariables = {
       OPENCODE_BIN="${llmpkgs.opencode2}/bin/opencode2";
    };
  };
}
