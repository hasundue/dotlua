require("telescope").setup({
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--hidden", "--no-ignore", "--strip-cwd-prefix" }
    }
  }
})
