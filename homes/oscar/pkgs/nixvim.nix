let
  nixvim = import (
    builtins.fetchGit {
      url = "https://github.com/nix-community/nixvim";
      ref = "nixos-23.11";
    }
  );
in {
  imports = [nixvim.homeManagerModules.nixvim];
  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";
    colorschemes.tokyonight.enable = true;
    clipboard.register = "unnamedplus";
    options = {
      number = true;
      shiftwidth = 2;
    };
    plugins = {
      which-key.enable = true;
      luasnip.enable = true;
      undotree.enable = true;
      treesitter.enable = true;
      clangd-extensions.enable = true;
      todo-comments.enable = true;
      refactoring.enable = true;
      rainbow-delimiters.enable = true;
      nvim-cmp = {
        enable = true;
        mappingPresets = [
          "insert"
          "cmdline"
        ];
        preselect = "Item";
      };
      notify.enable = true;
      neo-tree.enable = true;
      rust-tools.enable = true;
      dashboard.enable = true;
      nvim-autopairs.enable = true;
      none-ls.enable = true;
      multicursors.enable = true;
      copilot-lua.enable = true;
      noice = {
        enable = true;
      };
      mini = {
        enable = true;
        modules = {
          ai = {};
          bufremove = {};
          surround = {};
          comment = {};
          hipatterns = {};
          indentscope = {};
        };
      };
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          ccls.enable = true;
          clangd.enable = true;
          csharp-ls.enable = true;
          omnisharp.enable = true;
          eslint.enable = true;
          gopls.enable = true;
          html.enable = true;
          java-language-server.enable = true;
          lua-ls.enable = true;
          nixd.enable = true;
          nil_ls.enable = true;
          pylsp.enable = true;
          ruff-lsp.enable = true;
          tsserver.enable = true;
        };
      };
      better-escape = {
        enable = true;
        mapping = [
          "jj"
          "jk"
        ];
      };
      telescope = {
        enable = true;
        extensions = {
          file_browser.enable = true;
          frecency.enable = true;
        };
      };
      lualine = {
        enable = true;
        componentSeparators = {
          left = "|";
          right = "|";
        };
        sectionSeparators = {
          left = "";
          right = "";
        };
        sections = {
          lualine_a = [
            {
              separator = {
                left = "";
              };
              padding = {
                right = 2;
                left = 0;
              };
            }
          ];
          lualine_b = ["branch"];
          lualine_c = [];
          lualine_x = [];
          lualine_y = ["progress"];
          lualine_z = [
            {
              separator = {
                right = "";
              };
              padding = {
                left = 2;
                right = 0;
              };
            }
          ];
        };
        inactiveSections = {
          lualine_a = ["filename"];
          lualine_b = [];
          lualine_c = [];
          lualine_x = [];
          lualine_y = [];
          lualine_z = ["location"];
        };
      };
    };
    keymaps = [
      {
        action = "<cmd>w<cr><esc>";
        key = "<C-s>";
        options.desc = "Save file";
      }
      {
        action = "<cmd>qa<cr>";
        key = "<leader>qq";
        options.desc = "Quit all";
      }
      {
        action = "<cmd>noh<cr><esc>";
        key = "<esc>";
        options.desc = "Escape and clear hlsearch";
      }
      # move to window using <ctrl> hjkl keys
      {
        action = "<C-w>h";
        key = "<C-h>";
        options.remap = true;
      }
      {
        action = "<C-w>j";
        key = "<C-j>";
        options.remap = true;
      }
      {
        action = "<C-w>k";
        key = "<C-k>";
        options.remap = true;
      }
      {
        action = "<C-w>l";
        key = "<C-l>";
        options.remap = true;
      }
      # move lines
      # TODO
    ];
  };
}
