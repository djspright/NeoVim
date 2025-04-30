return {
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
    keys = {
      { '<gc>', function() require('Comment.api').toggle.linewise.current() end, mode = 'n', desc = 'Toggle comment line' },
      { '<gc>', function() require('Comment.api').toggle.linewise(vim.fn.visualmode()) end, mode = 'v', desc = 'Toggle comment selection' },
    }
  }
}

