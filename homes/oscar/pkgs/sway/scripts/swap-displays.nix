pkgs:
pkgs.writeShellScript "sway-swap-displays" ''
  #!/bin/sh
  swaymsg "$(swaymsg -t get_workspaces | ${pkgs.lib.getExe pkgs.jq} -r '
      [.[] | select(.visible) ] |
          "workspace \(.[0].name), move workspace to output \(.[1].output), "
          + "workspace \(.[1].name), move workspace to output \(.[0].output), "
          + (
              if $ARGS.positional | any(contains("follow")) then
                  "workspace \(.[] | select(.focused).name)"
              else
                  "focus output \(.[] | select(.focused).output)"
              end
          )
      ' --args "$@")"
''
