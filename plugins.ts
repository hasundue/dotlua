import { ClosedGroup, Group } from "./lib/specs.ts";

export default ClosedGroup(
  // dpp.vim and extensions (a plugin manager)
  ...Group({ lazy: false, rtp: "" }, [
    "Shougo/dpp.vim",
    "Shougo/dpp-ext-lazy",
  ]),
  // Colorscheme and UIs
  ...Group({ lazy: false }, [
    "rebelot/kanagawa.nvim",
    {
      repo: "nvim-lualine/lualine.nvim",
      depends: "nvim-web-devicons",
    },
    "nvim-tree/nvim-web-devicons",
  ]),
  ...Group({ event: "CursorHold" }, [
    {
      repo: "folke/noice.nvim",
      depends: ["nui.nvim", "nvim-notify"],
    },
  ]),
  // Highlighting and diagnostics
  ...Group({ event: "BufRead" }, [
    {
      repo: "b0o/incline.nvim",
      depends: "nvim-web-devicons",
    },
    {
      repo: "neovim/nvim-lspconfig",
      // plenary is required in our configuration
      depends: ["cmp-nvim-lsp", "noice.nvim", "plenary.nvim"],
    },
    "nvim-treesitter/nvim-treesitter",
    { repo: "lewis6991/gitsigns.nvim", setup: "gitsigns" },
    { repo: "shortcuts/no-neck-pain.nvim", exec: "NoNeckPain" },
  ]),
  // Completion
  ...Group({ event: ["CmdlineEnter", "InsertEnter"] }, [
    "hrsh7th/nvim-cmp",
    "zbirenbaum/copilot.lua",
  ]),
  // nvim-cmp extensions
  ...Group({ extends: "nvim-cmp" }, [
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "dcampos/cmp-snippy",
    "dcampos/nvim-snippy",
    { repo: "rinx/cmp-skkeleton", depends: "skkeleton" },
    { repo: "vim-skk/skkeleton", depends: "denops.vim" },
  ]),
  // Loaded when cursor moved (normal-mode plugins)
  ...Group({ event: "CursorMoved" }, [
    "machakann/vim-sandwich",
  ]),
  // Commands
  {
    repo: "nvim-telescope/telescope.nvim",
    depends: ["nvim-treesitter", "nvim-web-devicons", "plenary.nvim"],
    on: "telescope",
  },
  {
    repo: "stevearc/oil.nvim",
    depends: "nvim-web-devicons",
    on: "oil",
  },
  {
    repo: "voldikss/vim-floaterm",
    cmd: ["FloatermNew", "FloatermToggle"],
  },
  {
    repo: "iamcco/markdown-preview.nvim",
    cmd: "MarkdownPreview",
    build: 'sh -c "cd app && yarn install"',
  },
  {
    repo: "toppair/peek.nvim",
    on: "peek",
    build: "deno task -q build:fast",
  },
  // Libraries
  ...Group({ lazy: true }, [
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "rcarriga/nvim-notify",
    "vim-denops/denops.vim",
  ]),
);
