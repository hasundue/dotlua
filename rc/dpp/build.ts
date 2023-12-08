import { assertInstanceOf, copy } from "./lib/std.ts";
import { $XDG_CACHE_HOME, $XDG_DATA_HOME } from "./helper/mod.ts";
import { Plugin, safeStat } from "./lib/dpp_vim.ts";

const $CACHE = $XDG_CACHE_HOME + "/dpp/repos/github.com";
const $DATA = $XDG_DATA_HOME + "/nvim";

export async function buildPlugin(
  plugin: Plugin,
) {
  const data = `${$DATA}/plugins/${plugin.name}`;

  if (!plugin.build) {
    return { ...plugin, path: data };
  }
  const cache = `${$CACHE}/${plugin.repo}`;
  try {
    await Deno.mkdir(cache);
  } catch (e) {
    assertInstanceOf(e, Deno.errors.AlreadyExists);
    const revision = await tryGetRevision(cache);
    if (revision && revision === await getRevision(data)) {
      return { ...plugin, path: cache };
    }
  }
  await copy(data, cache, { overwrite: false });

  const [command, ...args] = plugin.build.split(" ");
  new Deno.Command(command, {
    args,
    cwd: cache,
    stdout: "inherit",
    stderr: "inherit",
  }).outputSync();

  return { ...plugin, path: cache };
}

// Copyright (c) Shougo Matsushita <Shougo.Matsu at gmail.com> - MIT License
// https://github.com/Shougo/dpp-protocol-git/blob/main/denops/%40dpp-protocols/git.ts#L401
async function getRevision(
  dir: string,
): Promise<string> {
  const gitDir = `${dir}/.git`;
  const headFileLine =
    (await Deno.readTextFile(`${gitDir}/HEAD`)).split("\n")[0];

  if (headFileLine.startsWith("ref: ")) {
    const ref = headFileLine.slice(5);
    if (await safeStat(`${gitDir}/${ref}`)) {
      return (await Deno.readTextFile(`${gitDir}/${ref}`)).split("\n")[0];
    }
    const lines = (await Deno.readTextFile(`${gitDir}/packed-refs`))
      .split("\n")
      .filter((line) => line.includes(` ${ref}`));
    for (const line of lines) {
      return line.replace(/^([0-9a-f]*) /, "$1");
    }
  }
  return headFileLine;
}

if (import.meta.main) {
  const { PLUGINS } = await import("./plugins.ts");
  await Promise.all(PLUGINS.map(buildPlugin));
}

async function tryGetRevision(dir: string): Promise<string | undefined> {
  try {
    return await getRevision(dir);
  } catch {
    return undefined;
  }
}
