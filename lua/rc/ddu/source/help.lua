local ddu = require("rc.ddu.util")

ddu.patch_local("help", {
  sources = {
    {
      name = "help",
      options = ddu.source_options(),
    },
  },
})
