-- plugin-independent configuration
require('rc.terminal')

-- use fish
vim.g.floaterm_shell = 'fish'

-- set the floaterm window size
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8

-- set highlights for floaterm windows
vim.api.nvim_set_hl(0, 'Floaterm', { link = 'NormalFloat', force = true })
vim.api.nvim_set_hl(0, 'FloatermBorder', { link = 'FloatBorder', force = true })
