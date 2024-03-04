local scandir = require("plenary.scandir")

local function library()
  local paths = {
    vim.env.VIMRUNTIME .. "/lua",
    "${3rd}/luv/library",
    "${3rd}/busted/library",
    "${3rd}/luassert/library",
    vim.fn.stdpath("config") .. "/lua",
    "./lua",
  }
  for _, dir in ipairs(
    scandir.scan_dir(vim.fn.stdpath("data") .. "/plugins", { depth = 1 })
  ) do
    if vim.uv.fs_stat(dir .. "/lua") then
      table.insert(paths, dir .. "/lua")
    end
  end
  return paths
end

return {
  settings = {
    Lua = {
      hint = {
        enable = false,
      },
      workspace = {
        checkThirdParty = false,
        library = library(),
      },
    },
  },
}
