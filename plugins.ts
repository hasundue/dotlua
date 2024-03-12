import { ClosedGroup, Group } from "./lib/specs.ts";

export default ClosedGroup(
  // dpp.vim and extensions (a plugin manager)
  ...Group({ lazy: false, rtp: "" }, [
    "Shougo/dpp.vim",
    "Shougo/dpp-ext-lazy",
  ]),
  // Non-lazy plugins (colorscheme, libraries, etc.)
  ...Group({ lazy: false }, [
    "nvim-lua/plenary.nvim",
    "rebelot/kanagawa.nvim",
  ]),
  // Highlighting and diagnostics
  ...Group({ event: "BufRead" }, [
    {
      repo: "neovim/nvim-lspconfig",
      // Need plenary for our configuration
      depends: ["cmp-nvim-lsp", "plenary.nvim"],
    },
    "nvim-treesitter/nvim-treesitter",
    { repo: "lewis6991/gitsigns.nvim", setup: "gitsigns" },
  ]),
  // nvim-lsp extensions
  ...Group({ extends: "nvim-lspconfig" }, [
    "ray-x/lsp_signature.nvim",
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
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
  ]),
  // Loaded when cursor moved (normal-mode plugins)
  ...Group({ event: "CursorMoved" }, [
    "machakann/vim-sandwich",
  ]),
  // Commands
  {
    repo: "nvim-telescope/telescope.nvim",
    depends: "plenary.nvim",
    on: "telescope",
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
  // denops.vim is only required by dpp.vim
  { repo: "vim-denops/denops.vim", lazy: true },
);
