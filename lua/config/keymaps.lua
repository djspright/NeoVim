-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- キーマップ設定
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })                                                  -- インサートモード終了
vim.keymap.set("n", "<leader>q", ":bd<CR>", { desc = "Close buffer" })                                                 -- バッファを閉じる
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })                                          -- 次のバッファに移動
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })                                    -- 前のバッファに移動
vim.keymap.set('t', '<C-o>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Terminal: Exit to Normal mode' }) -- ターミナルモードを抜ける

-- insert modeでhjklを使ってカーソル移動
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })                                                  -- インサートモード終了
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })                                                  -- インサートモード終了
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })                                                  -- インサートモード終了
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })                                                  -- インサートモード終了

-- vim.keymap.set('v', '<C-c>', '"+y', { noremap = true, silent = true, desc = 'Copy to clipboard (Ctrl+C)' })                                                 -- Ctrl + C でコピー
-- vim.keymap.set('i', '<C-v>', '<C-r>+', { noremap = true, silent = true, desc = 'Paste form clipboard (Ctrl+V)' })                                              -- Ctrl + V でペースト
-- vim.keymap.set('v', '<D-c>', '"+y', { noremap = true, silent = true, desc = 'Copy to clipboard (Cmd+C)' })                                                 -- Cmd + C でコピー
-- vim.keymap.set('i', '<D-v>', '<C-r>+', { noremap = true, silent = true, desc = 'Paste form clipboard (Ctrl+V)' })                                              -- Cmd + V でペースト
-- vim.keymap.set('n', '<D-v>', '"+p', { noremap = true, silent = true })                                                 -- Cmd + V でペースト（ノーマルモード）
-- vim.keymap.set('c', '<D-v>', '<C-r>+', { noremap = true, silent = true })                                              -- Cmd + V でペースト（コマンドモード）
-- vim.keymap.set('t', '<D-v>', '<C-\\><C-n>"+pi', { noremap = true, silent = true })                                     -- Cmd + V でペースト（ターミナルモード）
