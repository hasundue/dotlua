require("lib.lsp").on_attach(nil, function(client, bufnr)
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
