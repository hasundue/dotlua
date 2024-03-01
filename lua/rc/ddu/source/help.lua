local ddu = require("rc.ddu.util")

ddu.patch_local("help", {
  sources = {
    {
      name = "help",
      options = ddu.source_options(),
    },
  },
})

ddu.patch_global({
  kindOptions = {
    help = {
      defaultAction = 'open',
    }
  },
})

ddu.map('help', {
  { '<C-s>', ddu.item_action('open', { command = 'split' }) },
  { '<C-v>', ddu.item_action('open', { command = 'vsplit' }) },
  { '<C-t>', ddu.item_action('open', { command = 'tabedit' }) },
})
