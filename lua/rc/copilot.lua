require("copilot").setup({
  filetypes = {
    gitcommit = true,
    markdown = true,
    yaml = true,
  },
  panel = {
    enabled = false,
  },
  suggestion = {
    enabled = false, -- use copilot-cmp instead
  },
})
