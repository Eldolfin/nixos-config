return {
  "Exafunction/codeium.nvim",
  cmd = "Codeium",
  build = ":Codeium Auth",
  enabled = false,
  opts = {
    tools = {
      language_server = "/run/current-system/sw/bin/codeium_language_server",
    },
  },
}
