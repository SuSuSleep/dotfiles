return {
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        enabled = true,
        doc = {
          enabled = true,
          inline = true,
          float = true,
          max_width = 80,
          max_height = 40,
        },
        math = {
          enabled = true,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "latex" })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      latex = {
        enabled = false,
      },
    },
  },
}
