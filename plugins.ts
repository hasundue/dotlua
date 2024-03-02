import type { Plugin } from "dpp_vim/types.ts";
import { ClosedGroup, Group } from "./deno/groups.ts";

export const PLUGINS = ClosedGroup(
  // Bootstrap
  ...Group({ lazy: false, rtp: "" }, [
    {
      repo: "Shougo/dpp.vim",
    },
    {
      repo: "Shougo/dpp-ext-lazy",
      depends: ["dpp.vim"],
    },
  ]),
  // Merged into bootstrap
  ...Group({ lazy: false }, [
    {
      repo: "rebelot/kanagawa.nvim",
      lua_add: "require('rc.kanagawa')",
    },
  ]),
  // Very lazy but eventually loaded
  ...Group({ on_event: ["CursorHold"] }, [
    {
      repo: "vim-denops/denops.vim",
      lua_source: "require('rc.denops')",
    },
    {
      repo: "github/copilot.vim",
      lua_source: "require('rc.copilot')",
    },
  ]),
  // Loaded when reading any file
  ...Group({ on_event: ["BufRead"] }, [
    {
      repo: "lewis6991/gitsigns.nvim",
      lua_source: "require('gitsigns').setup()",
    },
    {
      repo: "nvim-treesitter/nvim-treesitter",
      lua_source: "require('rc.treesitter')",
    },
    {
      repo: "neovim/nvim-lspconfig",
      lua_source: "require('rc.lsp')",
      depends: ["cmp-nvim-lsp"],
    },
  ]),
  // nvim-lsp extensions
  ...Group({ on_source: ["nvim-lspconfig"] }, [
    {
      repo: "ray-x/lsp_signature.nvim",
    },
  ]),
  // Loaded when cursor moved (normal-mode plugins)
  ...Group({ on_event: ["CursorMoved"] }, [
    {
      repo: "machakann/vim-sandwich",
    },
  ]),
  // nvim-cmp and extensions
  ...Group({ on_event: ["CmdlineEnter", "InsertEnter"] }, [
    {
      repo: "hrsh7th/nvim-cmp",
      lua_source: "require('rc.cmp')",
    },
  ]),
  ...Group({ on_source: ["nvim-cmp"] }, [
    { repo: "hrsh7th/cmp-buffer" },
    { repo: "hrsh7th/cmp-cmdline" },
    { repo: "hrsh7th/cmp-nvim-lsp" },
    { repo: "hrsh7th/cmp-path" },
  ]),
  // ddu.vim and extensions
  {
    repo: "Shougo/ddu.vim",
    depends: ["denops.vim"],
    on_cmd: ["Ddu"],
    lua_add: "require('rc.ddu.keymap')",
    lua_source: "require('rc.ddu')",
  },
  ...Group({ on_source: ["ddu.vim"] }, [
    { repo: "Shougo/ddu-ui-ff" },
    {
      repo: "hasundue/ddu-filter-zf",
      build: "deno task build",
    },
    {
      repo: "kuuote/ddu-source-mr",
      depends: ["mr.vim"],
      lua_source: "require('rc.ddu.source.mr')",
    },
    {
      repo: "matsui54/ddu-source-file_external",
      lua_source: "require('rc.ddu.source.file_external')",
    },
    {
      repo: "matsui54/ddu-source-help",
      lua_source: "require('rc.ddu.source.help')",
    },
    {
      repo: "Shougo/ddu-kind-file",
      lua_source: "require('rc.ddu.kind.file')",
    },
    {
      repo: "shun/ddu-source-rg",
      lua_source: "require('rc.ddu.source.rg')",
    },
    {
      repo: "shun/ddu-source-buffer",
      lua_source: "require('rc.ddu.source.buffer')",
    },
    { repo: "uga-rosa/ddu-source-lsp" },
  ]),
  // floaterm
  {
    repo: "voldikss/vim-floaterm",
    on_cmd: ["FloatermNew", "FloatermToggle"],
    lua_add: "require('rc.floaterm.keymap')",
    lua_source: "require('rc.floaterm.config')",
  },
  // Markdown
  {
    repo: "iamcco/markdown-preview.nvim",
    on_cmd: ["MarkdownPreview"],
    build: 'sh -c "cd app && yarn install"',
  },
  // Miscelaneous
  {
    repo: "lambdalisue/mr.vim",
    on_source: ["ddu-source-mr"],
  },
) satisfies Plugin[];
