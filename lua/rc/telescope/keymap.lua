local builtin = require('telescope.builtin')

local function map(key, picker)
  vim.keymap.set('n', '<leader>' .. key, builtin[picker], {})
end

local mappings = {
  find_files = "a",
  buffers = "b",
  git_files = "f",
  help_tags = "h",
  live_grep = "l",
  resume = "r",
  grep_string = "s",
}

for picker, key in pairs(mappings) do
  map(key, picker)
end
