vim.opt.termguicolors = true

require('kanagawa').setup({
  colors = {
    -- Remove gutter background
    theme = { all = { ui = { bg_gutter = 'none' } } },
  },
  compile = false,     -- enable compiling the colorscheme
  dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  overrides = function(colors)
    local theme = colors.theme
    return {
      -- Transparent background
      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },

      -- Dark completion menu
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
      PmenuSel = { fg = "none", bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },

      -- Borderless Telescope
      TelescopeTitle = { fg = theme.ui.special, bold = true },
      TelescopePromptNormal = { bg = theme.ui.bg_p1 },
      TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
      TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_dim },
      TelescopeResultsBorder = { fg = theme.ui.bg_dim, bg = theme.ui.bg_dim },
      TelescopePreviewNormal = { bg = theme.ui.bg_dim },
      TelescopePreviewBorder = { fg = theme.ui.bg_dim, bg = theme.ui.bg_dim },

      -- Borderless Floaterm
      Floaterm = { fg = theme.ui.fg_dim, bg = theme.ui.bg_dim },
      FloatermBorder = { fg = theme.ui.bg_dim, bg = theme.ui.bg_dim },
    }
  end,
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  transparent = true,    -- do not set background color
  undercurl = true,      -- enable undercurls
})

vim.cmd('colorscheme kanagawa')
