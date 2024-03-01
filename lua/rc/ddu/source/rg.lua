local ddu = require("rc.ddu.utils")

ddu.patch_local("rg", {
  sources = {
    {
      name = "rg",
      options = {
        volatile = true,
      },
      params = {
        args = { "--json", "--smart-case" },
      },
    },
  },
})
