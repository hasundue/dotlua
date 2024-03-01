local ddu = require("rc.ddu.util")

ddu.patch_local("buffer", {
  sources = {
    {
      name = "buffer",
      options = ddu.source_options(),
    },
  },
})
