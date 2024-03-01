-- Plugins are assumed to be placed under the xdg data directory.
-- (e.g. ~/.local/share/nvim/plugins)
---@param name string
local function depends(name)
  vim.opt.runtimepath:prepend(
    vim.fn.stdpath("data") .. "/plugins/" .. name
  )
end

-- TODO: Make this configurable
local dpp_name = "main"

local dpp_base = vim.fn.stdpath("cache") .. "/dpp"
local dpp_state = dpp_base .. "/" .. dpp_name .. "/state.vim"
local dpp_config = vim.fn.stdpath("config") .. "/deno/dpp.ts"

depends("dpp.vim")
depends("dpp-ext-lazy")

local dpp = require("dpp")

if dpp.load_state(dpp_base, dpp_name) > 0 then
  vim.notify("[dpp] Creating " .. dpp_state .. " ...")

  depends("denops.vim")

  -- Need to load denops manually since we pass `--noplugin` to nvim
  vim.cmd("runtime! plugin/denops.vim")

  -- Make denops load our import maps
  vim.g["denops#server#deno_args"] = {
    "-q",
    "--no-lock",
    "-A",
    "--import-map",
    vim.fn.stdpath("config") .. "/deno.json",
  }

  vim.api.nvim_create_augroup("DppUserInit", { clear = true })

  vim.api.nvim_create_autocmd("User", {
    pattern = "DenopsReady",
    group = "DppUserInit",
    callback = function()
      dpp.make_state(dpp_base, dpp_config, dpp_name)
    end
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "Dpp:makeStatePost",
    group = "DppUserInit",
    callback = function()
      vim.notify("[dpp] Created " .. dpp_state)
    end
  })
end

vim.cmd("filetype indent plugin on")
vim.cmd("syntax on")
