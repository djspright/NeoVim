-- lua/plugins/ui-fidget.lua
return {
  "j-hui/fidget.nvim",
  opts = {
    -- ここにカスタムオプションを記述します
    -- 例：通知ウィンドウの設定を変更
    notification = {
      window = {
        winblend = 0,     -- ウィンドウの透明度 (0は不透明)
        align = "bottom", -- 表示位置を下に（"top"にも変更可能）
        x = "right",      -- 表示位置を右に（"left"にも変更可能）
      },
      -- 通知が消えるまでの時間（ミリ秒）
      timeout = 4000,
    },
    -- 進捗表示の設定
    progress = {
      display = {
        render_limit = 2, -- 同時に表示するタスクの最大数
      },
    },
  },
}
