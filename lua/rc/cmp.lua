local cmp = require("cmp")

-- True if we are in the beginning of the line, ignoring whitespaces and tabs.
---@return boolean
local function has_text_before()
  local line = vim.fn.getline(".")
  local col = vim.fn.col(".")
  return string.match(line:sub(1, col), "^%s*$") == nil
end

---@return boolean
local function copilot_visible()
  local status, copilot = pcall(require, "copilot.suggestion")
  if status then
    return copilot.is_visible()
  else
    return false
  end
end

cmp.setup({
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if copilot_visible() then
        require("copilot.suggestion").accept()
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif has_text_before() then
        cmp.complete()
      else
        fallback()
      end
    end),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  snippet = {
    expand = function(args)
      require("snippy").expand_snippet(args.body)
    end
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "snippy" },
  }, {
    { name = "buffer" },
  }),
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  })
})
