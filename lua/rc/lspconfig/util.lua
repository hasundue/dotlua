local M = {}

vim.api.nvim_create_augroup("UserLspConfig", { clear = false })

---Register callback function on LspAttach
---@param name string|nil If nil, global
---@param callback fun(client: vim.lsp.Client, bufnr: integer)
function M.on_attach(name, callback)
  vim.api.nvim_create_autocmd("LspAttach", {
    group = "UserLspConfig",
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and (name == nil or client.name == name) then
        callback(client, bufnr)
      end
    end,
  })
end

return M
