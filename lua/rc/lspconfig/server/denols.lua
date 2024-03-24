return {
  cmd = { "deno", "lsp" },
  root_dir = vim.uv.cwd,
  settings = {
    deno = {
      enable = true,
      unstable = true,
    },
    typescript = {
      inlayHints = {
        enabled = "on",
        functionLikeReturnTypes = { enabled = true },
      },
    },
  },
  single_file_support = true,
}
