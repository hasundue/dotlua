vim.api.nvim_create_user_command("Ddu", function(args)
  local ddu_name = args.args
  vim.fn["ddu#start"]({ name = ddu_name })
end, {
  nargs = 1,
  complete = function()
    return vim.tbl_keys(vim.fn["ddu#custom#get_local"]())
  end,
})

vim.keymap.set('n', '<leader>f', '<Cmd>Ddu file:find<CR>')
