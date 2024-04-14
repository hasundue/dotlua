local cmp = require("cmp")
local snippy = require("snippy")

-- True if we are in the beginning of the line, ignoring whitespaces and tabs.
---@return boolean
local has_text_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      elseif has_text_before() then
        cmp.complete()
      else
        fallback()
      end
    end),
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      else
        fallback()
      end
    end),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-e>"] = cmp.mapping.abort(),
  },
  snippet = {
    expand = function(args)
      require("snippy").expand_snippet(args.body)
    end
  },
  sources = cmp.config.sources(
    {
      { name = "copilot" },
      { name = "nvim_lsp" },
      { name = "snippy" },
    },
    {
      { name = "buffer" },
    },
    {
      { name = "emoji" },
    }
  ),
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
