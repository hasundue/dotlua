import { $HOME } from "../rc/dpp/env.ts";
import { type ClosedGroup } from "../rc/dpp/groups.ts";

async function updateFlake(
  plugins: ClosedGroup,
) {
  const original = await Deno.readTextFile(
    new URL("./flake.nix", import.meta.url),
  );
  const lines = original.split("\n");
  const leadings = lines.slice(
    0,
    lines.findIndex((line) => line.includes("PLUGINS START")) + 1,
  );
  const followings = lines.slice(
    lines.findLastIndex((line) => line.includes("PLUGINS END")),
  );
  const insertions = plugins.map((it) => {
    const { name, repo } = it;
    const url = repo.startsWith("~")
      ? `git+file:${repo.replace("~", $HOME)}`
      : `github:${repo}`;
    return `    "plugins/${name}" = { url = "${url}"; flake = false; };`;
  });
  await Deno.writeTextFile(
    new URL("./flake.nix", import.meta.url),
    [leadings, insertions, followings].flat().join("\n"),
  );
}

if (import.meta.main) {
  const { PLUGINS } = await import("../rc/dpp/plugins.ts");
  await updateFlake(PLUGINS);
}
