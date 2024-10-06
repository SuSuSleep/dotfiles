return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      python = { "pylint" },
      json = { "biome" },
      javascript = { "biome" },
      typescript = { "biome" },
      lua = { "selene" },
    },
  },
}
