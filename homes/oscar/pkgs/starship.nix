{
  programs.starship = {
    enable = true;
    settings = {
      format = "[░▒▓](#a3aed2)[  ](bg:#a3aed2 fg:#090c0c)[](bg:#769ff0 fg:#a3aed2)$hostname$directory[](fg:#769ff0 bg:#394260)$git_branch$git_status[](fg:#394260 bg:#212736)$c$cmake$cobol$daml$dart$deno$dotnet$elixir$elm$erlang$fennel$golang$guix_shell$haskell$haxe$helm$java$julia$kotlin$gradle$lua$nim$nodejs$ocaml$opa$perl$php$pulumi$purescript$python$raku$rlang$red$ruby$rust$scala$solidity$swift$terraform$vlang$vagrant$zig$nix_shell$conda$meson$spack$memory_usage$env_var$crystal$custom$sudo$cmd_duration$jobs$battery[](fg:#212736 bg:#1d2230)$time[ ](fg:#1d2230)\n$character";

      directory = {
        read_only = " 󰌾";
        style = "fg:#e3e5e5 bg:#769ff0";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      directory.substitutions = {
        "Documents" = "󰈙 ";
        "Downloads" = " ";
        "Music" = " ";
        "Pictures" = " ";
      };
      c = {
        symbol = "";
        style = "bg:#212736";
        format = ''[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'';
      };

      conda = {
        symbol = " ";
      };

      dart = {
        symbol = " ";
      };

      docker_context = {
        symbol = " ";
      };

      elixir = {
        symbol = " ";
      };

      elm = {
        symbol = " ";
      };

      fossil_branch = {
        symbol = " ";
      };

      git_branch = {
        symbol = "";
        style = "b:#394260";
        format = ''[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)'';
      };

      git_status = {
        style = "b:#394260";
        format = ''[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)'';
      };

      golang = {
        symbol = " ";
        style = "b:#212736";
        format = ''[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'';
      };

      guix_shell = {
        symbol = " ";
      };

      haskell = {
        symbol = " ";
      };

      haxe = {
        symbol = " ";
      };

      hg_branch = {
        symbol = " ";
      };

      hostname = {
        ssh_symbol = " ";
        style = "fg:#e3e5e5 bg:#769ff0";
        format = "[ $ssh_symbol$hostname in]($style)";
      };

      java = {
        symbol = "";
        style = "b:#212736";
        format = ''[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'';
      };

      julia = {
        symbol = " ";
      };

      lua = {
        symbol = "";
        style = "b:#212736";
        format = ''[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'';
      };

      memory_usage = {
        symbol = "󰍛 ";
      };

      meson = {
        symbol = "󰔷 ";
        style = "b:#212736";
        format = ''[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'';
      };

      nim = {
        symbol = "󰆥 ";
      };

      nix_shell = {
        symbol = "";
        style = "b:#212736";
        format = ''[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'';
        heuristic = true;
      };

      nodejs = {
        symbol = "";
        style = "b:#212736";
        format = ''[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'';
      };

      os.symbols = {
        Alpaquita = " ";
        Alpine = " ";
        Amazon = " ";
        Android = " ";
        Arch = " ";
        Artix = " ";
        CentOS = " ";
        Debian = " ";
        DragonFly = " ";
        Emscripten = " ";
        EndeavourOS = " ";
        Fedora = " ";
        FreeBSD = " ";
        Garuda = "󰛓 ";
        Gentoo = " ";
        HardenedBSD = "󰞌 ";
        Illumos = "󰈸 ";
        Linux = " ";
        Mabox = " ";
        Macos = " ";
        Manjaro = " ";
        Mariner = " ";
        MidnightBSD = " ";
        Mint = " ";
        NetBSD = " ";
        NixOS = " ";
        OpenBSD = "󰈺 ";
        openSUSE = " ";
        OracleLinux = "󰌷 ";
        Pop = " ";
        Raspbian = " ";
        Redhat = " ";
        RedHatEnterprise = " ";
        Redox = "󰀘 ";
        Solus = "󰠳 ";
        SUSE = " ";
        Ubuntu = " ";
        Unknown = " ";
        Windows = "󰍲 ";
      };

      package = {
        symbol = "󰏗 ";
      };

      pijul_channel = {
        symbol = " ";
      };

      python = {
        symbol = "";
        style = "b:#212736";
        format = ''[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'';
      };

      rlang = {
        symbol = "󰟔 ";
      };

      ruby = {
        symbol = " ";
      };

      rust = {
        symbol = "";
        style = "b:#212736";
        format = ''[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'';
      };

      scala = {
        symbol = " ";
      };

      cmd_duration = {
        style = "b:#212736";
        format = ''[took [$duration](fg:#769ff0 bg:#212736)]($style)'';
      };

      time = {
        format = ''[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)'';
        disabled = false;
        time_format = "%R"; # Hour:Minute Format;
        style = "bg:#1d2230";
      };
    };
  };
}
