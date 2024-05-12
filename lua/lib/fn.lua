local M = {}

---@param cmd string
M.cmd = function(cmd)
  return function()
    vim.cmd(cmd)
  end
end

return M
