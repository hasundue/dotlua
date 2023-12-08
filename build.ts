import { assertInstanceOf } from "https://deno.land/std@0.208.0/assert/assert_instance_of.ts";
import { $HOME, type ClosedGroup } from "./rc/dpp/helper/mod.ts";

async function updateFlake(
  plugins: ClosedGroup,
) {
  const original = await Deno.readTextFile(
    new URL("./flake.nix", import.meta.url),
  );
  const lines = original.split("\n");
  const head = lines.slice(
    0,
    lines.indexOf("    /* PLUGINS START */\n") + 1,
  );
  const tail = lines.slice(
    lines.indexOf("    /* PLUGINS END */"),
  );
  try {
    await Deno.mkdir(new URL("./plugins", import.meta.url), {
      recursive: true,
    });
  } catch (e) {
    assertInstanceOf(e, Deno.errors.AlreadyExists);
  }
  const insertion = plugins.map((it) => {
    const { name, repo } = it;
    const url = repo.startsWith("~")
      ? `git+file:${repo.replace("~", $HOME)}`
      : `github:${repo}`;
    return `    "plugin:${name}" = { url = "${url}"; flake = false; };`;
  });
  await Deno.writeTextFile(
    new URL("./plugins/flake.nix", import.meta.url),
    [head, insertion, tail].flat().join("\n"),
  );
}

if (import.meta.main) {
  const { PLUGINS } = await import("./rc/dpp/plugins.ts");
  await updateFlake(PLUGINS);
}
