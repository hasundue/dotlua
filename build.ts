import { assertInstanceOf } from "https://deno.land/std@0.208.0/assert/assert_instance_of.ts";
import { $HOME, type ClosedGroup } from "./rc/dpp/helper/mod.ts";

const HEAD = `{
  description = "hasundue's Neovim plugins (auto-generated)";

  inputs = {`;

const TAIL = `  };

  outputs = inputs: {
    plugins = inputs;
  };
}
`;

async function generateFlake(
  plugins: ClosedGroup,
) {
  try {
    await Deno.mkdir(new URL("./dist/plugins", import.meta.url), {
      recursive: true,
    });
  } catch (e) {
    assertInstanceOf(e, Deno.errors.AlreadyExists);
  }
  const lines = plugins.map((it) => {
    const { name, repo } = it;
    const url = repo.startsWith("~")
      ? `git+file:${repo.replace("~", $HOME)}`
      : `github:${repo}`;
    return `    "${name}" = { url = "${url}"; flake = false; };`;
  });
  await Deno.writeTextFile(
    new URL("./dist/plugins/flake.nix", import.meta.url),
    [HEAD, lines, TAIL].flat().join("\n"),
  );
}

if (import.meta.main) {
  const { PLUGINS } = await import("./rc/dpp/plugins.ts");
  await generateFlake(PLUGINS);
}
