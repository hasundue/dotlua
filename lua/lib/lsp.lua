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

local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities(),
  { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
)

---Setup a language server
---@param server string
---@param config table
function M.setup(server, config)
  require("lspconfig")[server].setup(
    vim.tbl_deep_extend("keep", config, {
      autostart = true,
      capabilities = capabilities,
    })
  )
end

return M
