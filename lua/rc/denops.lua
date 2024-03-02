vim.g["denops#server#deno_args"] = {
  "-q",
  "--no-lock",
  "-A",
  "--unstable-ffi", -- for ddu-filter-zf
  "--import-map",
  vim.fn.stdpath("config") .. "/deno.json"
}
