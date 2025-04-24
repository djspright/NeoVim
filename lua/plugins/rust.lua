return {
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return {
        tools = {
          runnables = {
            use_telescope = true,
          },
          inlay_hints = {
            auto = true,
            show_parameter_hints = true,
          },
        },
        server = {
          on_attach = function(_, bufnr)
            -- カーゴコマンド用のキーマッピング
            vim.keymap.set("n", "<leader>rr", "<cmd>RustRunnables<cr>", { buffer = bufnr, desc = "Runnables" })
            vim.keymap.set("n", "<leader>rt", "<cmd>RustDebuggables<cr>", { buffer = bufnr, desc = "Debuggables" })
            vim.keymap.set("n", "<leader>re", "<cmd>RustExpandMacro<cr>", { buffer = bufnr, desc = "Expand Macro" })
            vim.keymap.set("n", "<leader>rc", "<cmd>RustOpenCargo<cr>", { buffer = bufnr, desc = "Open Cargo.toml" })
          end,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
              cargo = {
                allFeatures = true,
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end,
  },
}
