local env = require("rc.dpp.env")

local M = {}

---@param plugin_name string
---@param opts? { dev: boolean }
function M.add(plugin_name, opts)
  opts = opts or {}
  local base = opts.dev and env.dev or env.plugins
  vim.opt.runtimepath:prepend(base .. "/" .. plugin_name)
end

vim.api.nvim_create_augroup("DppUserInit", { clear = false })

function M.autocmd(pattern, callback)
  vim.api.nvim_create_autocmd("User", {
    pattern = pattern,
    group = "DppUserInit",
    once = true,
    callback = callback,
  })
end

return M
