local M = {}

---@param name string
---@param params? table
---@return function
function M.action(name, params)
  return function()
    vim.fn["ddu#ui#do_action"](name, params or vim.empty_dict())
  end
end

---@param name string
---@param params? table
---@return function
function M.item_action(name, params)
  return M.action("itemAction", { name = name, params = params })
end

---@param cmd string
---@return function
function M.execute(cmd)
  return function()
    vim.fn["ddu#ui#ff#execute"](cmd)
    vim.cmd.redraw()
  end
end

---@param kind? string If nil, map is set globally
---@param maps { [1]: string, [2]: function }[]
function M.map(kind, maps)
  kind = kind or "default"
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "ddu-ff-filter",
    group = vim.api.nvim_create_augroup("ddu-map-" .. kind, { clear = false }),
    callback = function()
      -- Enable `file` map also for `file:foo`
      if kind == "default" or string.find(vim.b.ddu_ui_name, kind) then
        for _, map in pairs(maps) do
          local lhs, rhs = map[1], map[2]
          local opts = { nowait = true, buffer = true, silent = true }
          vim.keymap.set('i', lhs, rhs, opts)
        end
      end
    end,
  })
end

---@param dict table
function M.patch_global(dict)
  vim.fn["ddu#custom#patch_global"](dict)
end

---@param name string
---@param dict table
function M.patch_local(name, dict)
  vim.fn["ddu#custom#patch_local"](name, dict)
end

---@param type "ui"|"source"|"filter"|"kind"|"column"|"action"
---@param alias_name string
---@param base_name string
function M.alias(type, alias_name, base_name)
  vim.fn["ddu#custom#alias"](type, alias_name, base_name)
end

---@return table
function M.source_options()
  return {
    matchers = { "matcher_zf" },
    sorters = { "sorter_zf" },
    converters = { "converter_zf" },
  }
end

return M
