{
  config,
  lib,
  ...
}: let
  cfg = config.shared.fzf;
in
  with lib; {
    options.shared.fzf = {
      enable = mkEnableOption "Shared fzf";
    };

    config = mkIf cfg.enable {
      programs.fzf = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;

        colors = {
          "fg" = "#9f9e99";
          "fg+" = "#a7d8b0";
          "bg" = "#121212";
          "bg+" = "#161719";
          "hl" = "#9f9e99";
          "hl+" = "#a7d8b0";

          "spinner" = "#83799C";
          "marker" = "#87ff00";
          "prompt" = "#9f9e99";
          "pointer" = "#af5fff";
          "header" = "#6D7580";
          "info" = "#787487";

          "border" = "#262626";
          "query" = "#9f9e99";
          "label" = "#9a9a9a";
        };

        defaultOptions = [
          "--border=rounded"
          "--preview-window=border-rounded"
          "--prompt='> '"
          "--marker='>'"
          "--pointer='◆'"
          "--separator='─'"
          "--scrollbar='│'"
        ];
      };
    };
  }
