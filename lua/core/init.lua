-- enable experimental lua loader
vim.loader.enable()

-- core configurations
require("core.opt")
require("core.terminal")

-- plugin configurations
for _, v in ipairs {
  "cmp",
  "floaterm",
  "incline",
  "kanagawa",
  "lspconfig",
  "lualine",
  "noice",
  "no_neck_pain",
  "oil",
  "telescope",
  "terminal",
  "treesitter",
} do
  require("core." .. v)
end
