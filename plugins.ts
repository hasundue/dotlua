import { ClosedGroup, Group } from "./lib/specs.ts";

export default ClosedGroup(
  // dpp.vim and extensions (a plugin manager)
  ...Group({ lazy: false, rtp: "" }, [
    "Shougo/dpp.vim",
    "Shougo/dpp-ext-lazy",
  ]),
  // Colorscheme
  ...Group({ lazy: false }, [
    "rebelot/kanagawa.nvim",
  ]),
  // UI
  ...Group({ event: "BufRead" }, [
    {
      repo: "neovim/nvim-lspconfig",
      // Need plenary for our configuration
      depends: ["cmp-nvim-lsp", "plenary.nvim"],
    },
    "nvim-treesitter/nvim-treesitter",
    { repo: "lewis6991/gitsigns.nvim", setup: "gitsigns" },
  ]),
  // LSP
  ...Group({ extends: "nvim-lspconfig" }, [
    "ray-x/lsp_signature.nvim",
  ]),
  // Loaded when cursor moved (normal-mode plugins)
  ...Group({ event: "CursorMoved" }, [
    "machakann/vim-sandwich",
  ]),
  // Loaded when starting insert mode
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
  // denops.vim and related plugins
  ...Group({ depends: "denops.vim" }, [
    { repo: "Shougo/ddu.vim", cmd: "Ddu" },
  ]),
  // ddu extensions
  ...Group({ extends: "ddu.vim" }, [
    "Shougo/ddu-ui-ff",
    { repo: "hasundue/ddu-filter-zf", build: "deno task build" },
  ]),
  // ddu sources
  ...Group({ extends: "ddu.vim", prefix: "ddu-source-" }, [
    { repo: "kuuote/ddu-source-mr", depends: "mr.vim" },
    "matsui54/ddu-source-file_external",
    "matsui54/ddu-source-help",
    "shun/ddu-source-buffer",
    "shun/ddu-source-rg",
    "uga-rosa/ddu-source-lsp",
  ]),
  // ddu kinds
  ...Group({ extends: "ddu.vim", prefix: "ddu-kind-" }, [
    "Shougo/ddu-kind-file",
  ]),
  // Terminal
  {
    repo: "voldikss/vim-floaterm",
    cmd: ["FloatermNew", "FloatermToggle"],
  },
  { // Markdown
    repo: "iamcco/markdown-preview.nvim",
    cmd: "MarkdownPreview",
    build: 'sh -c "cd app && yarn install"',
  },
  // Dependencies
  ...Group({ lazy: true }, [
    "nvim-lua/plenary.nvim",
    "lambdalisue/mr.vim",
    "vim-denops/denops.vim",
  ]),
);
