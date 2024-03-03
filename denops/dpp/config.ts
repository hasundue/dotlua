import { Denops } from "dpp_vim/deps.ts";
import {
  BaseConfig,
  ConfigReturn,
  ContextBuilder,
  Dpp,
  Plugin,
} from "dpp_vim/types.ts";
import { initPlugin } from "../../lib/init_plugin.ts";
import specs from "../../plugins.ts";

type LazyMakeStateResult = {
  plugins: Plugin[];
  stateLines: string[];
};

export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
    dpp: Dpp;
  }) {
    const [context, options] = await args.contextBuilder.get(args.denops);

    const plugins = await Promise.all(specs.map(initPlugin));

    // Create a state with dpp-ext-lazy
    const makeStateResult = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "lazy",
      "makeState",
      { plugins },
    ) as LazyMakeStateResult;

    return {
      plugins: makeStateResult.plugins,
      stateLines: makeStateResult.stateLines,
    } satisfies ConfigReturn;
  }
}
