nnoremap <silent> <leader>f <Cmd>Ddu file_external
  \ -name=file -ui=ff -resume<CR>

nnoremap <silent> <leader>m <Cmd>Ddu mr
  \ -name=mr -ui=ff<CR>

nnoremap <silent> <leader>b <Cmd>Ddu buffer
  \ -name=buffer -ui=ff<CR>

nnoremap <silent> <leader>c <Cmd>Ddu file_external
  \ -name=rc -ui=ff -resume
  \ -source-option-file_external-path='`expand('~/neovim')`'<CR>

nnoremap <silent> <leader>r <Cmd>Ddu rg
  \ -name=grep -ui=ff -resume<CR>

nnoremap <silent> <leader>d <Cmd>Ddu help
  \ -name=help -ui=ff -resume<CR>
