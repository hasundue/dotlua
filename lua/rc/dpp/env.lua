local base = vim.fn.stdpath("cache") .. "/dpp"

-- TODO: Make this configurable
local name = "main"

local state = base .. "/" .. name .. "/state.vim"

return {
  base = base,
  config = vim.fn.stdpath("config") .. "/denops/dpp/config.ts",
  dev = vim.fn.expand("~"),
  name = name,
  plugins = vim.fn.stdpath("data") .. "/plugins",
  state = state,
}
