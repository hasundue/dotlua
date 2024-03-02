local ddc = require("rc.ddc.util")

ddc.patch_global({
  sourceOptions = {
    lsp = {
      mark = '[LSP]',
    },
  },
  sourceParams = {
    lsp = {
      confirmBehavior = "replace",
      enableResolveItem = true,
      enableAdditionalTextEdit = true,
      lspEngine = "nvim-lsp",
    },
  },
})
