local util = require("lspconfig.util")

require("lib.lsp").setup("ts_ls", {
  root_dir = util.root_pattern("tsconfig.json", "jsconfig.json", "package.json"),
  single_file_support = false,
})
