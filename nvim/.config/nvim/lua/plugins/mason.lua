return {
  {
    "williamboman/mason.nvim",
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
}
