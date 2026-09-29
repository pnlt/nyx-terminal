{
  config,
  lib,
  ...
}: let
  cfg = config.shared.less;
in
  with lib; {
    options.shared.less = {
      enable = mkEnableOption "Shared less";
    };

    config = mkIf cfg.enable {
      programs.less = {
        enable = true;

        options = {
          R = true;
          F = true;
          X = true;
          M = true;
          S = true;
          i = true;
          mouse = true;
        };
      };
    };
  }
