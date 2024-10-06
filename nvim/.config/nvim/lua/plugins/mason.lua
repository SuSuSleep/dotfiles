return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      -- python
      "pyright",
      "pylint",
      "black",
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
}
