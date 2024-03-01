local ddu = require('lib.ddu')

ddu.map('file', {
  { '<C-s>', ddu.item_action('open', { command = 'split' }) },
  { '<C-v>', ddu.item_action('open', { command = 'vsplit' }) },
})

ddu.patch_global({
  kindOptions = {
    mr = {
      defaultAction = 'open',
    }
  },
})
