/** @example /home/username */
export const $HOME = Deno.env.get("HOME")!;

/** @example ~/.cache */
export const $XDG_CACHE_HOME = Deno.env.get("XDG_CACHE_HOME")!;

/** @example ~/.config */
export const $XDG_CONFIG_HOME = Deno.env.get("XDG_CONFIG_HOME")!;

/** @example ~/.local/share */
export const $XDG_DATA_HOME = Deno.env.get("XDG_DATA_HOME")!;
