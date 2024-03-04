local env = require("rc.dpp.env")
local util = require("rc.dpp.util")

util.add("dpp.vim", { dev = true })
util.add("dpp-ext-lazy")

local dpp = require("dpp")

if dpp.load_state(env.base, env.name) then
  vim.notify("[dpp] Creating " .. env.state .. " ...")

  util.add("denops.vim")

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
    dpp.make_state(env.base, env.config, env.name)
  end)

  util.autocmd("Dpp:makeStatePost", function()
    vim.notify("[dpp] Created " .. env.state)
    dpp.load_state(env.base, env.name)
  end)
end
