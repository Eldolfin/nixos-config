-- manual lsp installs, because nix
local nvim_lsp = require("lspconfig")

nvim_lsp["pylsp"].setup({
	cmd = { "/home/oscar/.nix-profile/bin/pylsp" },
})

-- nvim_lsp["sqls"].setup({
--   cmd = { vim.fn.expand("$HOME/.nix-profile/bin/sqls") },
-- })

-- nvim_lsp["sqlfluff"].setup({
--   cmd = { vim.fn.expand("$HOME/.nix-profile/bin/sqlfluff") },
--   filetypes = { "sql" },
--   single_file_support = true,
-- })

nvim_lsp["lua_ls"].setup({
	cmd = { vim.fn.expand("$HOME/.nix-profile/bin/lua-language-server") },
})

nvim_lsp["clangd"].setup({
	cmd = { vim.fn.expand("/run/current-system/sw/bin/clangd") },
	capabilities = {
		offsetEncoding = { "utf-16" },
	},
})

nvim_lsp["gopls"].setup({
	cmd = { vim.fn.expand("$HOME/.nix-profile/bin/gopls") },
})

-- local rt = require("rust-tools")
-- this is to avoir overwriting rust-tools configs
-- rt.config.options.server.cmd = { "/home/oscar/.nix-profile/bin/rust-analyzer" }
-- nvim_lsp["rust_analyzer"].setup({
--   cmd = { "/home/oscar/.nix-profile/bin/rust-analyzer" },
-- })

nvim_lsp["omnisharp"].setup({
	cmd = { "/home/oscar/.nix-profile/bin/OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
})

nvim_lsp["nil_ls"].setup({
	cmd = { "nil" },
})

nvim_lsp["hls"].setup({
	cmd = { "haskell-language-server-wrapper", "--lsp" },
})

nvim_lsp["ocamllsp"].setup({
	cmd = { "ocamllsp" },
})

nvim_lsp["zls"].setup({
	cmd = { "zls" },
})
-- nvim_lsp["pyright"].setup({
--   cmd = { "/home/oscar/.nix-profile/bin/pyright-langserver", "--stdio" },
-- })

-- nvim_lsp["postgres_lsp"].setup({
--   name = "postgres_lsp",
--   cmd = { "postgres_lsp" },
--   filetypes = { "sql" },
--   single_file_support = true,
--   -- root_dir = util.root_pattern("root-file.txt"),
-- })
