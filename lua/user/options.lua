-- options.luaでの基本的な透明化設定
vim.opt.termguicolors = true
vim.opt.winblend = 0       -- ウィンドウの透明度
vim.opt.pumblend = 0       -- ポップアップメニューの透明度

-- 背景透過の設定
vim.api.nvim_command('highlight Normal guibg=NONE ctermbg=NONE')
vim.api.nvim_command('highlight NonText guibg=NONE ctermbg=NONE')
vim.api.nvim_command('highlight LineNr guibg=NONE ctermbg=NONE')
vim.api.nvim_command('highlight Folded guibg=NONE ctermbg=NONE')
vim.api.nvim_command('highlight EndOfBuffer guibg=NONE ctermbg=NONE')

-- colorscheme.luaでのDracula設定
vim.cmd('colorscheme dracula')

-- Draculaの設定後に透明化を適用（カラースキームが上書きする可能性があるため）
vim.api.nvim_command('highlight Normal guibg=NONE ctermbg=NONE')
vim.api.nvim_command('highlight SignColumn guibg=NONE ctermbg=NONE')
vim.api.nvim_command('highlight NormalNC guibg=NONE ctermbg=NONE')
vim.api.nvim_command('highlight MsgArea guibg=NONE ctermbg=NONE')
vim.api.nvim_command('highlight TelescopeBorder guibg=NONE ctermbg=NONE')
vim.api.nvim_command('highlight NvimTreeNormal guibg=NONE ctermbg=NONE')
