local lspconfig = require("lspconfig")

return {
  cmd = { "deno", "lsp" },
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  settings = {
    deno = {
      enable = true,
      unstable = true,
    },
    typescript = {
      inlayHints = {
        enabled = "on",
        functionLikeReturnTypes = { enabled = true },
        parameterTypes = { enabled = true },
      },
    },
  },
  single_file_support = true,
}
