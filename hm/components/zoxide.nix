{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isLinux isDarwin;
  cfg = config.shared.zoxide;
in
  with lib; {
    options.shared.zoxide = {
      enable = mkEnableOption "Shared Zoxide";
    };

    config = mkIf cfg.enable {
      programs.zoxide = {
        enable = true;
        package = pkgs.zoxide.overrideAttrs (old: {
          patches = (old.patches or []) ++ [./zoxide-acronyms.patch];
          patchFlags = ["-p1" "--forward"];
        });
        enableZshIntegration = true;
        enableBashIntegration = isLinux;
        enableFishIntegration = isDarwin;
        options = ["--cmd cd"];
      };
    };
  }
