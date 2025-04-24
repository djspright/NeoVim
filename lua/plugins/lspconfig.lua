return {
  -- 1. LSP基本設定
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/neodev.nvim", -- Neovim開発用のLSP設定（オプション）
    },
    opts = {
      servers = {
        -- C/C++用のclangd
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--suggest-missing-includes",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders=false", -- エラー修正
          },
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
        -- Rust用のrust-analyzer
        rust_analyzer = {
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
        -- 他の言語サーバーを追加
      },
    },
  },
  
  -- 2. LSPサーバーマネージャー
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "clangd",         -- C/C++
        "rust-analyzer",  -- Rust
        -- 必要な他のLSPサーバーを追加
      },
    },
  },
  
  -- 3. MasonとLSPconfigの連携
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_installation = true,
    },
  },
}
