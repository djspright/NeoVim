return {
  "akinsho/toggleterm.nvim",
  version = "*",  -- 最新の安定版を使用
  lazy = false,   -- 起動時に読み込む
  config = function()
    require("toggleterm").setup({
      -- デフォルト設定
      size = 20,               -- ターミナルの高さ（垂直方向の場合）または幅（水平方向の場合）
      open_mapping = [[<C-\>]], -- ターミナルを開くキーマッピング（Ctrl+\）
      hide_numbers = true,     -- 行番号を非表示
      shade_filetypes = {},
      shade_terminals = false,  -- ここを必ずfalseに
      shading_factor = 0,      -- シェーディングを0に設定
      start_in_insert = true,  -- ターミナルを開くときにインサートモードに
      insert_mappings = true,  -- インサートモードでもマッピングを有効に
      persist_size = true,     -- ターミナルのサイズを保持
      direction = "horizontal",     -- float, vertical, horizontal, tab
      close_on_exit = true,    -- プロセスが終了したときにウィンドウを閉じる
      shell = "/usr/bin/fish",     -- 使用するシェル
      float_opts = {
        border = "curved",     -- 境界線のスタイル
        winblend = 15,         -- 透明度（0-100）
      },
      highlights = {
        Normal = {
          guibg = "NONE",
        },
        NormalFloat = {
          guibg = "NONE",
        },
        FloatBorder = {
          guibg = "NONE",
        },
        -- 以下を追加
        ToggleTerm = {
          guibg = "NONE",
        },
        ToggleTermNormal = {
          guibg = "NONE",
        },
      },
      -- 以下は変更なし
    })
    -- 残りの設定
  end,
}
