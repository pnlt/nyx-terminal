{
  config,
  lib,
  ...
}: let
  cfg = config.shared.fastfetch;
  esc = builtins.fromJSON ''"\u001b"'';
  # Column of the box's left edge: logo padding + widest logo line + gap.
  infoCol = 26;
  keyWidth = 14;
  valueWidth = 26;
  # Values have no common width, so the right edge is drawn by moving the
  # cursor to an absolute column instead of padding.
  inner = keyWidth + valueWidth;
  rightEdge = "${esc}[${toString (infoCol + inner + 1)}G{#bright_black}│";
  rule = lib.concatStrings (lib.replicate inner "─");
  # ANSI names, so the colors follow the terminal palette.
  border = left: right: {
    type = "custom";
    format = "{#bright_black}${left}${rule}${right}";
  };
  row = type: key: format: {
    inherit type;
    key = "{#bright_black}│ {#blue}${key}";
    format = "${format}${rightEdge}";
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
              top = 3;
              left = 2;
              right = 4;
            };
          };

          display = {
            separator = "";
            key.width = keyWidth;
            color.output = "white";
            size.binaryPrefix = "iec";
          };

          modules = [
            (border "╭" "╮")
            (row "title" " user" "{user-name}")
            (row "title" "󰒋 host" "{host-name}")
            (row "os" " distro" "{pretty-name}")
            (row "kernel" " kernel" "{release}")
            (row "wm" " wm" "{pretty-name} {version}")
            (row "packages" "󰏖 packages" "{all} (nix)")
            (row "shell" " shell" "{pretty-name} {version}")
            (row "terminal" " term" "{pretty-name} {version}")
            (row "cpu" " cpu" "{name}")
            (row "gpu" "󰢮 gpu" "{name}")
            (row "memory" "󰍛 memory" "{used} / {total}")
            ((row "disk" "󰋊 disk" "{size-used} / {size-total}") // {hideFS = "tmpfs";})
            (row "uptime" "󰅐 uptime" "{formatted}")
            (border "╰" "╯")
            "break"
            {
              type = "colors";
              symbol = "circle";
              paddingLeft = 2;
            }
          ];
        };
      };
    };
  }
