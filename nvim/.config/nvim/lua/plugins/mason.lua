return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- python
        "ruff",
        -- lua
        "lua-language-server",
        "stylua",
        "selene",
        -- yaml
        "yaml-language-server",
        "yamlfmt",
        -- javascript
        "biome",
      },
    },
  },
  { "mason-org/mason-lspconfig.nvim" },
}
