return {
{
  "Mofiqul/dracula.nvim",
  priority = 1000,
  config = function()
    require("dracula").setup({
      transparent_bg = true,
      italic_comment = true,
      command_height = 1,
      terminal_colors = true,
      overrides = {
        -- カーソル色を紫に設定
        Cursor = { fg = "#11111b", bg = "#59c2c6" },
        iCursor = { fg = "#11111b", bg = "#59c2c6" },
        lCursor = { fg = "#11111b", bg = "#59c2c6" },
        CursorIM = { fg = "#11111b", bg = "#59c2c6" },
      },
    })

    vim.cmd("colorscheme dracula")
    
    -- カラースキーム適用後にカーソルの設定を追加
    vim.opt.guicursor = "n-v-c:block-Cursor/lCursor"
    vim.opt.guicursor:append("i-ci:ver100-iCursor")
    vim.opt.guicursor:append("r-cr:hor100")
    vim.opt.guicursor:append("sm:block-blinkwait175-blinkoff150-blinkon175")
  end,
},
	-- LazyVimのデフォルトカラースキーム設定を上書き
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}
