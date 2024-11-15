-- enable experimental lua loader
vim.loader.enable()

-- base configuration, independent of plugins (keymaps, etc)
require("rc")

-- enable nvim-treesitter manuallly since it is not managed by dpp
require("rc.treesitter")

-- load plugins with dpp.vim
require("rc.dpp")
