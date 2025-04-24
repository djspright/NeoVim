return {
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require("clangd_extensions").setup({
        server = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
          },
        },
        extensions = {
          autoSetHints = true,
          inlay_hints = {
            inline = true,
          },
        },
      })
    end,
  },
}
