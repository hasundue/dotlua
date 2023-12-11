"
" hook_source {{{
"
call ddc#custom#patch_global(#{
  \   autoCompleteEvents: [
  \     'InsertEnter',
  \     'TextChangedI',
  \     'TextChangedP',
  \   ],
  \   backspaceCompletion: v:true,
  \   sources: [
  \     'lsp',
  \   ],
  \   ui: 'pum',
  \ })

call ddc#custom#patch_global('keywordPattern', '(\k*)|(:\w*)')

call ddc#custom#patch_global('sourceOptions', #{
  \   _: #{
  \     maxItems: 10,
  \     minAutoCompleteLength: 1,
  \     matchers: ['matcher_fuzzy'],
  \     sorters: ['sorter_fuzzy'],
  \     converters: ['converter_fuzzy'],
  \   },
  \   lsp: #{
  \     mark: 'L',
  \     forceCompletionPattern: '\S[\.\[\(\{\/]\S*'
  \   },
  \ })

call ddc#custom#patch_global('sourceParams', #{
  \   lsp: #{
  \     lspEngine: 'nvim-lsp',
  \   },
  \ })

call ddc#custom#patch_global('filterParams', {
  \   'matcher_fuzzy': {
  \     'splitMode': 'word'
  \   }
  \ })

call ddc#enable()

" }}}

"
" hook_add {{{
"
inoremap <expr> <C-n> pum#visible()
  \ ? '<Cmd>call pum#map#insert_relative(+1)<CR>'
  \ : ddc#map#manual_complete()

inoremap <C-p> <Cmd>call pum#map#insert_relative(-1)<CR>

inoremap <expr> <TAB> pum#visible()
  \ ? '<C-n>'
  \ : getline('.')[0:col('.')] =~# '[\s\\]*' 
  \   ? '<TAB>' 
  \   : ddc#map#manual_complete()

inoremap <expr> <S-Tab> pum#visible()
  \ ? '<Cmd>call pum#map#insert_relative(-1)<CR>'
  \ : '<C-h>'

inoremap <C-y> <Cmd>call pum#map#confirm()<CR>
inoremap <C-e> <Cmd>call pum#map#cancel()<CR>

" }}}
