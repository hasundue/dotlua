-- enable experimental lua loader
vim.loader.enable()

for _, v in ipairs {
  "cmp",
  "floaterm",
  "incline",
  "kanagawa",
  "lsp",
  "lualine",
  "noice",
  "no_neck_pain",
  "oil",
  "opt",
  "telescope",
  "terminal",
  "treesitter",
} do
  require("core." .. v)
end
