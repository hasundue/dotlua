local env = require("rc.dpp.env")
local util = require("rc.dpp.util")

util.add("dpp.vim")
util.add("dpp-ext-lazy")

local dpp = require("dpp")

local function load_state(base, name)
  if dpp.load_state(base, name) then
    return true
  end
  vim.cmd("filetype indent plugin on")
  vim.cmd("syntax on")
end

if load_state(env.base, env.name) then
  vim.notify("[dpp] Creating " .. env.state .. " ...")

  util.add("denops.vim")

  -- Need to source denops manually since we pass `--noplugin` to nvim
  vim.cmd("runtime! plugin/denops.vim")
  require("rc.denops")

  util.autocmd("DenopsReady", function()
    dpp.make_state(env.base, env.config, env.name)
  end)

  util.autocmd("Dpp:makeStatePost", function()
    vim.notify("[dpp] Created " .. env.state)
    -- Immediately load the created state
    load_state(env.base, env.name)
  end)
end
