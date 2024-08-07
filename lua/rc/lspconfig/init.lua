local lspconfig = require("lspconfig")
local scandir = require("plenary.scandir")
local util = require("rc.lspconfig.util")

util.on_attach(nil, function(client, bufnr)
  local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, buffer = bufnr })
  end

  map('n', '<M-k>', vim.diagnostic.open_float)
  map('n', '<M-n>', vim.diagnostic.goto_next)
  map('n', '<M-p>', vim.diagnostic.goto_prev)

  if client.name == "copilot" then
    return
  end

  if client.supports_method("hover") then
    map('n', 'K', vim.lsp.buf.hover)
  end

  if client.supports_method("rename") then
    map('n', '<M-r>', vim.lsp.buf.rename)
  end

  if client.supports_method("inlay_hint") then
    map('n', "<M-i>", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
    end)
    vim.cmd('highlight link LspInlayHint NonText')
  end

  if client.supports_method("format") then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
      callback = function()
        vim.cmd('silent! lua vim.lsp.buf.format({ async = false })')
      end,
    })
  end
end)

local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities(),
  { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
)

for _, path in ipairs(
  scandir.scan_dir(vim.fn.stdpath("config") .. "/lua/rc/lspconfig/server")
) do
  local server = path:match("([^/]+)%.lua$")
  if server then
    local config = require("rc.lspconfig.server." .. server)
    lspconfig[server].setup(
      vim.tbl_deep_extend("keep", config, {
        autostart = true,
        capabilities = capabilities,
      })
    )
  end
end
