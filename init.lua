-- LazyVimのnvim-cmp関連extrasを無効化(自分の設定を優先)
vim.g.lazyvim_plugins_disabled = {
  "lazyvim.plugins.extras.coding.nvim-cmp"
}

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("user.options")
require("plugins.42header")

-- キーマップ設定
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true})  -- インサートモード終了
vim.keymap.set("n", "<leader>q", ":bd<CR>", { desc = "Close buffer" }) -- バッファを閉じる
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true, silent = true }) -- Ctrl + C でコピー
vim.keymap.set('i', '<C-v>', '<C-r>+', { noremap = true, silent = true }) -- Ctrl + V でペースト
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true }) -- 次のバッファに移動
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true }) -- 前のバッファに移動

-- Windowsのクリップボードと連携
vim.g.clipboard = {
  name = 'win32yank-wsl',
  copy = {
    ['+'] = 'win32yank.exe -i --crlf',
    ['*'] = 'win32yank.exe -i --crlf',
  },
  paste = {
    ['+'] = 'win32yank.exe -o --lf',
    ['*'] = 'win32yank.exe -o --lf',
  },
  cache_enabled = 0,
}

-- 最後のバッファを閉じたらダッシュボードを表示
vim.api.nvim_create_autocmd("User", {
  pattern = "BdeletePost",
  callback = function()
    if #vim.fn.getbufinfo({ buflisted = 1 }) == 0 then
      vim.cmd("Alpha")
    end
  end,
})

-- nvim-cmpの設定が確実に読み込まれたか確認するためのフラグ
vim.api.nvim_create_autocmd("User",{
  pattern = "LazyDone",
  callback = function()
    local has_cmp, cmp = pcall(require, "cmp")
    if has_cmp then
      print("nvim-cmp is loaded")
    else
      print("WARNING: nvim-cmp is not loaded")
    end
  end,
})

-- ToggleTermの透明化設定
vim.api.nvim_create_autocmd("FileType", {
  pattern = "toggleterm",
  callback = function()
    vim.api.nvim_set_hl(0, "ToggleTerm", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "ToggleTermNormal", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "ToggleTermFloat", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "ToggleTermBorder", { bg = "NONE", ctermbg = "NONE" })
  end,
})

-- Telescopeの透明化設定
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "NONE", ctermbg = "NONE" })
  end,
})

-- 42 format on save
local formatgrp = vim.api.nvim_create_augroup("C_format_42", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.h", "*.cpp", "*.hpp" },
  callback = function()
    -- 現在のバッファの内容を保存
    local current_buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)
    -- フォーマット実行（非同期ではなく同期的に）
    vim.cmd("CFormat42")
    -- 短い遅延を入れる（フォーマッターが処理を完了するまで待機）
    vim.defer_fn(function()
      -- フォーマットの変更が失われないようにするための処理
      local formatted = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)
      if vim.deep_equal(lines, formatted) then
        print("警告: フォーマットが適用されていません")
      else
        print("フォーマット成功")
      end
    end, 100)
  end,
  -- command = "CFormat42",
  group = formatgrp,
})

-- 42 format using keybindings
vim.api.nvim_set_keymap("n", "<F2>", ":CFormat42<CR>", { noremap = true, silent = true })

vim.g.autoformat = false -- LazyVimのグローバル自動フォーマットを無効化
