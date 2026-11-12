{
  config,
  lib,
  ...
}: let
  cfg = config.shared.fastfetch;
  # ANSI names, so the colors follow the terminal palette.
  module = type: key: {
    inherit type key;
    keyColor = "blue";
  };
in
  with lib; {
    options.shared.fastfetch.enable = mkEnableOption "Shared fastfetch";

    config = mkIf cfg.enable {
      programs.fastfetch = {
        enable = true;
        settings = {
          logo = {
            type = "file";
            source = "${./nixos.txt}";
            color = {
              "1" = "blue";
              "2" = "magenta";
            };
            padding = {
              top = 2;
              left = 2;
              right = 4;
            };
          };

          display = {
            separator = "  ";
            key.width = 12;
            color.output = "white";
            size.binaryPrefix = "iec";
          };

          modules = [
            {
              type = "title";
              format = "{user-name-colored}{at-symbol-colored}{host-name-colored}";
              color = {
                user = "magenta";
                at = "bright_black";
                host = "blue";
              };
            }
            {
              type = "custom";
              format = "{#bright_black}───────────────────────────────";
            }
            (module "os" " distro")
            (module "kernel" " kernel")
            (module "wm" " wm")
            (module "packages" "󰏖 packages")
            (module "shell" " shell")
            (module "terminal" " term")
            (module "cpu" " cpu")
            (module "gpu" "󰢮 gpu")
            (module "memory" "󰍛 memory")
            ((module "disk" "󰋊 disk") // {hideFS = "tmpfs";})
            (module "uptime" "󰅐 uptime")
            "break"
            {
              type = "colors";
              symbol = "circle";
              paddingLeft = 1;
            }
          ];
        };
      };
    };
  }
