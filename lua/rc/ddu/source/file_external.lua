local ddu = require("lib.ddu")

ddu.patch_local("file:find", {
  sources = {
    name = "file_external",
    params = {
      cmd = vim.split("git ls-files -co --exclude-standard", " "),
    },
    options = {
      matchers = { "matcher_zf" },
      sorters = { "sorter_zf" },
      converters = { "converter_zf" },
    },
  },
})
