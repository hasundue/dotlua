import { walk } from "@std/fs";
import { Denops } from "dpp_vim/deps.ts";
import {
  BaseConfig,
  ConfigReturn,
  ContextBuilder,
  Dpp,
  Plugin,
} from "dpp_vim/types.ts";
import { buildPlugin } from "./build.ts";
import { $XDG_CONFIG_HOME } from "./env.ts";
import { PLUGINS } from "../plugins.ts";

type LazyMakeStateResult = {
  plugins: Plugin[];
  stateLines: string[];
};

const $CONFIG = $XDG_CONFIG_HOME + "/nvim";

export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
    dpp: Dpp;
  }) {
    const [context, options] = await args.contextBuilder.get(args.denops);

    const plugins = await Promise.all(PLUGINS.map(buildPlugin));

    // Create a state with dpp-ext-lazy
    const makeStateResult = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "lazy",
      "makeState",
      { plugins },
    ) as LazyMakeStateResult;

    // Create a list of files to check
    const checkFiles = await Array.fromAsync(walk($CONFIG + "/rc"))
      .then((entries) => entries.map((entry) => entry.path));

    return {
      checkFiles,
      plugins: makeStateResult.plugins,
      stateLines: makeStateResult.stateLines,
    } satisfies ConfigReturn;
  }
}
