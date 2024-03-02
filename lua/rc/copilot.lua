vim.g.copilot_filetypes = {
  ["ddu-ff-filter"] = false,
  markdown = true,
}

vim.keymap.set("i", "<C-l>", "<Plug>(copilot-accept-word)")
