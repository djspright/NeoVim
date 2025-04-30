return {
  "FtVim/ft_count_lines.nvim",
  event = "VeryLazy",
  config = function()
    require("ft_count_lines").setup({
      enable_on_start = true
    })
  end
}
