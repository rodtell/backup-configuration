return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
  end,
  opts = {
    style = "night",
    on_colors = function(colors) end,
    on_highlights = function(highlights, colors) end,
    semantic_tokens = true,
  },
}
