return {
  {
    "nvim-telescope/telescope.nvim",
    -- すでにLazyVimにインストールされているため、depsの指定は不要
    -- 既存の設定に追加したい場合は、optsまたはconfigを使用
    keys = {
      -- キーマッピングの追加
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep Files" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
      -- C/C++/Rust開発用
      { "<leader>ft", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type Definitions" },
      { "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    },
    opts = {
      defaults = {
        prompt_prefix = "🔍 ",
        selection_caret = "❯ ",
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
      },
      -- 拡張機能の設定
      extensions = {
        fzf = {
          fuzzy = true, -- ファジー検索を有効
          override_generic_sorter = true, -- デフォルトのソーターを上書き
          override_file_sorter = true, -- デフォルトのファイルソーターを上書き
          case_mode = "smart_case", -- smart_case (デフォルト), ignore_caseまたはrespect_case
        },
      },
    },
  },
  -- fzf拡張を追加（検索速度を向上させる）
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
}
