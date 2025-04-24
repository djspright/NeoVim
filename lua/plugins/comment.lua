return {
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
    keys = {
      { '<C-_>', function() require('Comment.api').toggle.linewise.current() end, mode = 'n', desc = 'Toggle comment line' },
      { '<C-_>', function() require('Comment.api').toggle.linewise(vim.fn.visualmode()) end, mode = 'v', desc = 'Toggle comment selection' },
    }
  }
}

