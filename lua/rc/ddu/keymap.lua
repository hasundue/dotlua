vim.api.nvim_create_user_command("Ddu", function(args)
  local ddu_name = args.args
  vim.call("ddu#start", { name = ddu_name })
end, {
  nargs = 1,
  complete = function()
    return vim.tbl_keys(vim.call("ddu#custom#get_local"))
  end,
})

---@param keys string
---@param name string
local function map(keys, name)
  vim.keymap.set('n', keys, '<Cmd>Ddu ' .. name .. '<CR>')
end

map('<leader>b', 'buffer')
map('<leader>f', 'file')
map('<leader>h', 'help')
map('<leader>m', 'mr')
map('<leader>r', 'rg')
