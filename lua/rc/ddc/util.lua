local M = {}

function M.start()
  vim.call("ddc#enable")
end

function M.patch_global(...)
  vim.call("ddc#custom#patch_global", ...)
end

function M.patch_filetype(...)
  vim.call("ddc#custom#patch_filetype", ...)
end

function M.patch_buffer(...)
  vim.call("ddc#custom#patch_buffer", ...)
end

function M.insert_next()
  vim.call("ddc#map#insert_item", 1)
end

function M.insert_prev()
  vim.call("ddc#map#insert_item", -1)
end

function M.start_completion()
  vim.call("ddc#map#manual_complete")
end

function M.confirm()
  vim.call("pum#map#confirm")
end

function M.cancel()
  vim.call("pum#map#cancel")
end

-- True if we are in the beginning of the line, ignoring whitespaces and tabs.
---@return boolean
function M.is_indenting()
  local line = vim.fn.getline(".")
  local col = vim.fn.col(".")
  return string.match(line:sub(1, col), "^[%s\\]*$") ~= nil
end

---@return boolean
local function is_visible()
  return vim.call("ddc#visible")
end

---@param lhs string
---@param rhs_if_visible function
---@param rhs_else? function | string | nil
function M.map(lhs, rhs_if_visible, rhs_else)
  rhs_else = type(rhs_else) == "function" and rhs_else or function()
    return rhs_else
  end
  vim.keymap.set("i", lhs, function()
    if is_visible() then
      return rhs_if_visible()
    else
      return rhs_else()
    end
  end, { expr = true })
end

return M
