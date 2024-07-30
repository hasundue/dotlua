import { basename } from "@std/path";
import type { AutocmdEvent } from "denops_std/autocmd/mod.ts";

export type RepoSpec<
  Owner extends string = string,
  Name extends string = string,
> = `${Owner}/${Name}`;

export type RepoName<R = RepoSpec> = R extends `${infer _Owner}/${infer Name}`
  ? Name
  : never;

export type PluginConfig<
  Rs extends RepoName = RepoName,
> = {
  /** The build command */
  build?: string;
  /** The command(s) that loads the plugin */
  cmd?: string | string[];
  /** The event(s) that loads the plugin */
  event?: AutocmdEvent | AutocmdEvent[];
  /** Execute the command when the plugin is loaded */
  exec?: string;
  /** The plugin(s) that extended by (or depends on) this plugin */
  extends?: Rs | Rs[];
  /** The plugin(s) that this plugin depends on */
  depends?: Rs | Rs[];
  /** True if the plugin is a development (local) version */
  dev?: boolean;
  /** True if the plugin is lazy-loaded */
  lazy?: boolean;
  /** Load the plugin when the Lua module is required */
  on?: string;
  /** Specify the prefix of the plugin used for the directory name of Lua module */
  prefix?: string;
  /** Call `require(...)` when the plugin is sourced */
  require?: string;
  /** The runtimepath of the plugin */
  rtp?: string;
  /** Call `require(...).setup()` when the plugin is sourced */
  setup?: string;
};

export type PluginSpec<
  R extends RepoSpec = RepoSpec,
  Ns extends RepoName = RepoName,
> =
  | R
  | { repo: R } & PluginConfig<Ns>;

export function Group<
  Rs extends RepoSpec = RepoSpec,
  Ns extends RepoName = never,
>(
  descriptor: PluginConfig<Ns>,
  specs: PluginSpec<Rs, Ns>[],
): PluginSpec<Rs, Ns>[] {
  return specs.map(
    // TODO: Do not override but merge
    (it): PluginSpec<Rs, Ns> =>
      typeof it === "string"
        ? { repo: it, ...descriptor }
        : { ...it, ...descriptor },
  );
}

export type ClosedGroup<
  Rs extends RepoSpec = RepoSpec,
> = {
  [R in Rs]: PluginSpec<R, RepoName<Rs>>;
}[Rs][];

export function ClosedGroup<
  Rs extends RepoSpec = RepoSpec,
>(
  ...plugins: PluginSpec<Rs, RepoName<Rs>>[]
): ClosedGroup<Rs> {
  return plugins;
}

export function toName(from: RepoSpec): RepoName {
  return basename(from);
}
