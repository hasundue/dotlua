local ddu = require("rc.ddu.utils")

ddu.patch_local("buffer", {
  sources = {
    {
      name = "buffer",
      options = ddu.source_options(),
    },
  },
})
