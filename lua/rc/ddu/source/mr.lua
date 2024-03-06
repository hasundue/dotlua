local ddu = require('rc.ddu.util')

ddu.map('mr', {
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

ddu.patch_local('mr', {
  sources = {
    {
      name = 'mr',
      options = ddu.source_options(),
    },
  },
})
