require("lib.lsp").setup("nil_ls", {
  cmd = { "nil" },
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  },
})
