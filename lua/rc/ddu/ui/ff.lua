local ddu = require('lib.ddu')

ddu.map(nil, {
  -- Close UI
  { '<C-[>', ddu.action('quit') },
  -- Move cursor
  { '<C-n>', ddu.action('cursorNext') },
  { '<C-p>', ddu.action('cursorPrevious') },
  -- Default itemAction
  { '<CR>',  ddu.item_action('default') },
})
