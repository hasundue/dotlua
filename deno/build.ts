import { assertInstanceOf } from "@std/assert";
import { copy } from "@std/fs";
import { join } from "@std/path";
import { CommandBuilder } from "dax/mod.ts";
import { Plugin } from "dpp_vim/types.ts";
import { $XDG_CACHE_HOME, $XDG_DATA_HOME } from "./env.ts";

const $CACHE = $XDG_CACHE_HOME + "/nvim/dpp/main/repos/github.com";
const $DATA = $XDG_DATA_HOME + "/nvim";

/**
 * Set `path` property to the plugin and run `build` command if exists.
 *
 * TODO: Run `build` command when the plugin is updated.
 */
export async function buildPlugin(
  plugin: Plugin,
): Promise<Plugin & { path: string }> {
  const data = `${$DATA}/plugins/${plugin.name}`;

  if (!plugin.build) {
    return { ...plugin, path: data };
  }

  const cache = `${$CACHE}/${plugin.repo}`;
  try {
    await Deno.mkdir(cache, { recursive: true });
    await Deno.chmod(cache, 0o755);
    for await (const entry of Deno.readDir(data)) {
      await copy(join(data, entry.name), join(cache, entry.name), {
        overwrite: false,
      });
    }
  } catch (e) {
    assertInstanceOf(e, Deno.errors.AlreadyExists, e);
    return { ...plugin, path: cache };
  }

  console.log(`Building ${plugin.name}...`);
  await new CommandBuilder().command(plugin.build!).cwd(cache);

  return { ...plugin, path: cache };
}

if (import.meta.main) {
  const { PLUGINS } = await import("../plugins.ts");
  await Promise.all(PLUGINS.map(buildPlugin));
}
