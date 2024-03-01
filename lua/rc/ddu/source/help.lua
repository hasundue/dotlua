local ddu = require("rc.ddu.utils")

ddu.patch_local("help", {
  sources = {
    {
      name = "help",
      options = ddu.source_options(),
    },
  },
})
