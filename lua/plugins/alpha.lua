return {
  "goolord/alpha-nvim",
  dependencies = { "MaximilianLloyd/ascii.nvim" },
  opts = function(_, opts)
    opts.section.header.val = require("ascii.text.neovim").sharp
    return opts
  end,
}
