local M = {}

---@param name string
function M.depends(name)
  vim.opt.runtimepath:prepend(
    vim.fn.stdpath("data") .. "/plugins/" .. name
  )
end

vim.api.nvim_create_augroup("DppUserInit", { clear = true })

function M.autocmd(pattern, callback)
  vim.api.nvim_create_autocmd("User", {
    pattern = pattern,
    group = "DppUserInit",
    callback = callback,
  })
end

return M
