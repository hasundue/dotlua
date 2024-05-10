local devicons = require("nvim-web-devicons")

require("incline").setup({
  window = {
    margin = { horizontal = 0 },
  },
  render = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    if filename == "" then
      return nil
    end
    local ft_icon, ft_color = devicons.get_icon_color(filename)
    local modified = vim.bo[props.buf].modified
    return {
      ft_icon and { ft_icon, " ", guifg = ft_color } or "",
      { filename, gui = modified and "bold,italic" or "bold" },
    }
  end,
})
