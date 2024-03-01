-- enable experimental lua loader
vim.loader.enable()

-- base configuration, independent of plugins (keymaps, etc)
require("rc.base")

-- load plugins with dpp.vim
require("rc.dpp")
