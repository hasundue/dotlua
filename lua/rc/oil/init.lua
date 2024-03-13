local winblend = vim.opt.winblend:get()

require("oil").setup({
  keymaps_help = {
    border = "solid",
  },
  float = {
    border = "solid",
    win_options = {
      winblend = winblend,
    },
  },
  preview = {
    border = "solid",
    win_options = {
      winblend = winblend,
    },
  },
  progress = {
    border = "solid",
    win_options = {
      winblend = winblend,
    },
  },
  ssh = {
    border = "solid",
  },
})
