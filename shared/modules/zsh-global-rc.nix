{
  config,
  lib,
  ...
}: let
  aliases = lib.filterAttrs (_: v: v != null) config.environment.shellAliases;
in {
  config = lib.mkIf config.shared.zsh.enable {
    environment.etc."zsh/global-rc.zsh".text = ''
      ${lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v: "alias -- ${k}=${lib.escapeShellArg v}") aliases)}

      ${config.environment.interactiveShellInit}
    '';
  };
}
