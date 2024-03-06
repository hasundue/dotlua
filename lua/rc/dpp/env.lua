local base = vim.fn.stdpath("cache") .. "/dpp"

-- TODO: Make this configurable
local name = "main"

return {
  base = base,
  cache = base .. "/" .. name .. "/cache.vim",
  config = vim.fn.stdpath("config") .. "/denops/dpp/config.ts",
  dev = vim.fn.expand("~"),
  name = name,
  plugins = vim.fn.stdpath("data") .. "/plugins",
  state = base .. "/" .. name .. "/state.vim",
}
