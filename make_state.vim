function s:add(plugin_name)
  execute 'set runtimepath^=' .. stdpath('data') .. '/plugins/' .. a:plugin_name
endfunction

const s:dpp_base = '~/.cache/dpp'->expand()
const s:dpp_state = s:dpp_base .. '/nvim/state.vim'

" Add dpp and ext-lazy to runtimepath (required)
call s:add('dpp.vim')
call s:add('dpp-ext-lazy')

echo '[dpp] Creating ' .. s:dpp_state .. ' ...'

" Add denops and to runtimepath (required)
call s:add('denops.vim')

" Need to load denops manually since we pass `--noplugin` to nvim
runtime! plugin/denops.vim

autocmd User DenopsReady
  \ call dpp#make_state(s:dpp_base, stdpath('config') .. '/rc/dpp/config.ts')

autocmd User Dpp:makeStatePost
  \ echo '[dpp] Created ' .. s:dpp_state |
  \ call denops#server#stop() |
  \ qa
