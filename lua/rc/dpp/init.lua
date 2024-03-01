local util = require("rc.dpp.util")

-- TODO: Make this configurable
local dpp_name = "main"

local dpp_base = vim.fn.stdpath("cache") .. "/dpp"
local dpp_state = dpp_base .. "/" .. dpp_name .. "/state.vim"
local dpp_config = vim.fn.stdpath("config") .. "/deno/dpp.ts"

util.depends("dpp.vim")
util.depends("dpp-ext-lazy")

local dpp = require("dpp")

if dpp.load_state(dpp_base, dpp_name) > 0 then
  vim.notify("[dpp] Creating " .. dpp_state .. " ...")

  util.depends("denops.vim")

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

  util.autocmd("DenopsReady", function()
    dpp.make_state(dpp_base, dpp_config, dpp_name)
  end)

  util.autocmd("Dpp:makeStatePost", function()
    vim.notify("[dpp] Created " .. dpp_state)
    dpp.load_state(dpp_base, dpp_name)
  end)
end

vim.cmd("filetype indent plugin on")
vim.cmd("syntax on")
