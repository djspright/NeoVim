-- Usage
-- <Alt-Left>: Back to previous file
-- <Alt-Right>: Forward to next file
-- `:Back`: Back to previous file
-- `:Forward`: Forward to next file

return {
  {
    "Bakudankun/BackAndForward.vim",
    keys = {
      { "<A-Left>", "<cmd>Back<cr>", desc = "前のファイルに戻る"},
      { "<A-Right>", "<cmd>Forward<cr>", desc = "次のファイルに進む"},
  },
  cmd = { "Back", "Forward" },
  config = function()
    -- jumpoptions
    vim.opt.jumpoptions:append("stack")
  end,
  },
}
