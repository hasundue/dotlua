import { assertInstanceOf } from "@std/assert";
import { copy, exists } from "@std/fs";
import { join } from "@std/path";
import { CommandBuilder } from "dax/mod.ts";
import { Plugin } from "dpp_vim/types.ts";
import {
  $HOME,
  $XDG_CACHE_HOME,
  $XDG_CONFIG_HOME,
  $XDG_DATA_HOME,
} from "./env.ts";
import { PluginSpec, RepoName, toName } from "./specs.ts";

const $CACHE = $XDG_CACHE_HOME + "/nvim/dpp/main/repos/github.com";
const $DATA = $XDG_DATA_HOME + "/nvim";
const $RC = $XDG_CONFIG_HOME + "/nvim/lua/rc";

/**
 * Convert a repository name to a simplified plugin name.
 *
 * - Remove a leading `vim-` or `nvim-`
 * - Remove a trailing `.vim` `.nvim`, or `.lua`
 */
function toLuaModuleName(name: RepoName, prefix: string): string {
  const base = prefix.replaceAll("-", ".");
  return base + name
    .replace(prefix, "")
    .replace(/^(vim|nvim)-/, "")
    .replace(/\.(vim|nvim|lua)$/, "");
}

async function hasInitLua(mod: string): Promise<boolean> {
  const base = mod.replaceAll(".", "/");
  for (
    const path of [
      join($RC, base + ".lua"),
      join($RC, base, "init.lua"),
    ]
  ) {
    if (await exists(path)) {
      return true;
    }
  }
  return false;
}

async function hasKeymapLua(mod: string): Promise<boolean> {
  if (await exists(join($RC, mod, "keymap.lua"))) {
    return true;
  }
  return false;
}

/**
 * Convert our `PluginSpec` to dpp's `Plugin`.
 *
 * TODO: Run `build` command when the plugin is updated.
 */
export async function initPlugin(
  spec: PluginSpec,
): Promise<Plugin & { path: string }> {
  spec = typeof spec === "string" ? { repo: spec } : spec;
  const name = toName(spec.repo);
  const data = spec.dev ? `${$HOME}/${name}` : `${$DATA}/plugins/${name}`;

  const mod = toLuaModuleName(name, spec.prefix ?? "");

  const lua_add = await hasKeymapLua(mod)
    ? `require("rc.${mod}.keymap")`
    : spec.lazy === false && spec.rtp !== ""
    ? (
      await hasInitLua(mod)
        ? `require("rc.${mod}")`
        : spec.require
        ? `require("${spec.require}")`
        : spec.setup
        ? `require("${spec.setup}").setup()`
        : undefined
    )
    : undefined;

  const lua_source = spec.lazy !== false
    ? (spec.require
      ? `require("${spec.require}")`
      : spec.setup
      ? `require("${spec.setup}").setup()`
      : await hasInitLua(mod)
      ? `require("rc.${mod}")`
      : undefined)
    : undefined;

  const lua_post_source = spec.exec ? `vim.cmd("${spec.exec}")` : undefined;

  const cache = `${$CACHE}/${spec.repo}`;
  if (spec.build) {
    try {
      await Deno.mkdir(cache, { recursive: true });
      await Deno.chmod(cache, 0o755);
      for await (const entry of Deno.readDir(data)) {
        await copy(join(data, entry.name), join(cache, entry.name), {
          overwrite: false,
        });
      }
      console.log(`Building ${name}...`);
      await new CommandBuilder().command(spec.build).cwd(cache);
    } catch (e) {
      assertInstanceOf(e, Deno.errors.AlreadyExists);
    }
  }

  const plugin = {
    depends: spec.depends,
    lazy: spec.lazy,
    lua_add,
    lua_source,
    lua_post_source,
    name,
    on_cmd: spec.cmd,
    on_event: spec.event,
    on_lua: spec.on,
    on_source: spec.extends,
    path: spec.build ? cache : data,
    rtp: spec.rtp,
  };
  // Need this for dpp.vim to work
  for (const key in plugin) {
    // @ts-ignore TS7053
    if (plugin[key] === undefined) delete plugin[key];
  }
  return plugin;
}

if (import.meta.main) {
  const { default: specs } = await import("../plugins.ts");
  await Promise.all(specs.map(initPlugin));
}
