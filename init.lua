-- enable experimental lua loader
vim.loader.enable()

-- base configuration, independent of plugins (keymaps, etc)
require("rc")

-- load plugins with dpp.vim
require("rc.dpp")
