import {
  ActionArguments,
  Actions,
  BaseExt,
  BaseExtParams,
} from "https://deno.land/x/dpp_vim@v0.0.9/types.ts";

type ExtParams = BaseExtParams & {
  cooldown: number;
};

type WatchCallbackArgs = {
  event: Deno.FsEvent;
} & ActionArguments<ExtParams>;

type WatchParams = {
  path: string;
  target: Deno.FsEvent["kind"];
  fn: (args: WatchCallbackArgs) => void | Promise<void>;
};

export class Ext extends BaseExt<ExtParams> {
  actions: Actions<ExtParams> = {
    watch: {
      description:
        "Watch changes to a file or directory and execute a function",

      callback: async (args) => {
        const { path, target, fn } = args.actionParams as WatchParams;
        const { cooldown } = args.extParams;

        const watcher = Deno.watchFs(path);
        let lastRun = 0;

        for await (const event of watcher) {
          if (target === "any" || event.kind === target) {
            const now = Date.now();
            if (now - lastRun < cooldown) {
              continue;
            }
            fn({ ...args, event }); // we don't have to await this
            lastRun = now;
          }
        }
      },
    },
  };
  params(): ExtParams {
    return {
      cooldown: 1000,
    };
  }
}
