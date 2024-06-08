-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- greatest remap ever (paste without replacing yank)
vim.keymap.set("x", "<leader>p", '"_dP')

local Job = require("plenary.job")

-- async
local function custom_make()
  vim.api.nvim_command("write")
  Job:new({
    command = "alacritty",
    args = { "-o", "font.size=10", "-e", "bash", "-c", "i3-msg floating enable; make check || sleep 1d" },
  }):start()
end

-- Run make with F9
vim.api.nvim_set_keymap(
  "n",
  "<F9>",
  -- ":w | topleft vs | terminal make<CR>:startinsert<CR>",
  -- ":w | !alacritty -e bash -c 'i3-msg floating enable; make || sleep 1d'<CR>",
  "",
  { noremap = true, silent = true, callback = custom_make }
)

if vim.g.neovide then
  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.10)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.10)
  end)
  vim.o.guifont = "MesloLGS NF:h14" -- text below applies for VimScript
end

vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)
