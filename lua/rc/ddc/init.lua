local ddc = require("rc.ddc.util")

--
-- Keymaps ---------------------------------------------------------
--
ddc.map("<C-n>", ddc.insert_next, ddc.start_completion)
ddc.map("<C-p>", ddc.insert_prev)

ddc.map("<Tab>", ddc.insert_next, function()
  if ddc.is_indenting() then
    return "<Tab>"
  else
    ddc.start_completion()
  end
end)
ddc.map("<S-Tab>", ddc.insert_prev, "<S-Tab>")

ddc.map("<C-y>", ddc.confirm)
ddc.map("<C-e>", ddc.cancel)

--
-- Global Options --------------------------------------------------
--
ddc.patch_global({
  autoCompleteEvents = {
    "InsertEnter",
    "TextChangedI",
  },
  backspaceCompletion = true,
  filterParams = {
    matcher_fuzzy = {
      splitMode = "word",
    },
  },
  sourceOptions = {
    _ = {
      minAutoCompleteLength = 1,
      matchers = { "matcher_fuzzy" },
      sorters = { "sorter_fuzzy" },
      converters = { "converter_fuzzy" },
    },
    ignoreCase = true,
    timeout = 1000,
  },
  sources = { "lsp" },
  ui = "pum",
})

--
-- Filetype-specific options
--
ddc.patch_filetype("typescript", {
  sourceOptions = {
    _ = {
      forceCompletionPattern = [[\S[\.\[\(\{\/]\S*]]
    },
  },
})

-- Start ddc
ddc.start()
