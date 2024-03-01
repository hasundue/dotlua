local ddu = require('lib.ddu')

ddu.map(nil, {
  -- Close UI
  { '<C-[>', ddu.action('quit') },
  -- Move cursor
  { '<C-n>', ddu.action('cursorNext') },
  { '<C-p>', ddu.action('cursorPrevious') },
  -- Default itemAction
  { '<CR>',  ddu.item_action('default') },
  -- Refresh items
  { '<C-l>', ddu.action('redraw', { method = 'refreshItems' }) },
})

ddu.patch_global({
  ui = 'ff',
  uiParams = {
    ff = {
      autoAction = { name = 'preview' },
      filterFloatPosition = 'top',
      filterSplitDirection = 'floating',
      floatingBorder = 'single',
      highlights = {
        floating = 'NormalFloat',
        floatingBorder = 'FloatBorder',
      },
      previewFloating = true,
      previewFloatingBorder = 'single',
      previewWindowOptions = {
        { '&cursorline', 0 },
        { '&number',     0 },
        { '&ruler',      0 },
      },
      prompt = '> ',
      startAutoAction = true,
      startFilter = true,
      split = 'floating',
    },
  },
})

local function resize()
  local lines = vim.opt.lines:get()
  local height, row = math.floor(lines * 0.8), math.floor(lines * 0.1)
  local columns = vim.opt.columns:get()
  local width, col = math.floor(columns * 0.8), math.floor(columns * 0.1)
  local previewWidth = math.floor(width / 2)

  ddu.patch_global({
    uiParams = {
      ff = {
        winHeight = height,
        winRow = row,
        winWidth = width,
        winCol = col,
        previewHeight = height,
        previewRow = row,
        previewWidth = previewWidth,
        previewCol = col + (width - previewWidth),
      },
    },
  })
end

resize()

vim.api.nvim_create_autocmd("VimResized", {
  callback = resize,
})
