return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      ["python"] = { "black" },
      ["json"] = { "biome" },
      ["javascript"] = { "biome" },
      ["typescript"] = { "biome" },
      ["bash"] = { "beautysh" },
      ["yaml"] = { "yamlfmt" },
    },
  },
}
