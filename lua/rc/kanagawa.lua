vim.opt.termguicolors = true

require('kanagawa').setup({
  colors = {
    theme = { all = { ui = { bg_gutter = 'none' } } },
  },
  compile = false,  -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = false },
  functionStyle = {},
  keywordStyle = { italic = false },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = true,    -- do not set background color
  dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
})

vim.cmd('colorscheme kanagawa')
