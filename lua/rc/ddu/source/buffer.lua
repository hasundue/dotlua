local ddu = require("rc.ddu.util")

ddu.patch_local("buffer", {
  sources = {
    {
      name = "buffer",
      options = ddu.source_options(),
    },
  },
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*",
  callback = function()
    vim.call("ddu#redraw", "buffer", { method = "refreshItems" })
  end,
})
